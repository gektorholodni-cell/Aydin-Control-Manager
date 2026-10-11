-- Structra: схема базы данных Supabase.
-- Выполнить один раз: Supabase Dashboard -> SQL Editor -> New query -> вставить файл -> Run.
-- Скрипт можно запускать повторно: всё создаётся через IF NOT EXISTS / OR REPLACE.

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------------
-- Компании и сотрудники
-- ---------------------------------------------------------------------------

create table if not exists public.companies (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  invite_code text not null unique
    default upper(substr(encode(gen_random_bytes(6), 'hex'), 1, 8)),
  created_at timestamptz not null default now()
);

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  company_id uuid not null references public.companies (id) on delete cascade,
  full_name text not null default '',
  role text not null default 'projectManager',
  created_at timestamptz not null default now()
);

-- Компания текущего пользователя. SECURITY DEFINER, чтобы политики RLS
-- на profiles не вызывали сами себя рекурсивно.
create or replace function public.current_company_id()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select company_id from public.profiles where id = auth.uid()
$$;

-- ---------------------------------------------------------------------------
-- Рабочие данные компании
-- ---------------------------------------------------------------------------

create table if not exists public.projects (
  id text primary key default gen_random_uuid()::text,
  company_id uuid not null default public.current_company_id()
    references public.companies (id) on delete cascade,
  name text not null,
  client text not null default '',
  address text not null default '',
  progress numeric not null default 0,
  status text not null default 'planning',
  start_date timestamptz,
  end_date timestamptz,
  number_of_employees integer not null default 0,
  budget numeric not null default 0,
  remaining_budget numeric not null default 0,
  description text not null default '',
  current_stage text not null default '',
  last_activity text not null default '',
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.tasks (
  id text primary key default gen_random_uuid()::text,
  company_id uuid not null default public.current_company_id()
    references public.companies (id) on delete cascade,
  project_id text,
  project_name text not null default '',
  title text not null,
  description text not null default '',
  priority text not null default 'medium',
  status text not null default 'notStarted',
  assignee_name text not null default '',
  start_date timestamptz,
  deadline timestamptz,
  progress numeric not null default 0,
  estimated_cost numeric not null default 0,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.photo_reports (
  id text primary key default gen_random_uuid()::text,
  company_id uuid not null default public.current_company_id()
    references public.companies (id) on delete cascade,
  album_name text not null,
  project_name text not null default '',
  task_name text not null default '',
  employee_name text not null default '',
  description text not null default '',
  location text not null default '',
  -- Пути файлов в Storage-бакете photo-reports: <company_id>/<report_id>/<file>
  before_photos text[] not null default '{}',
  after_photos text[] not null default '{}',
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);

create index if not exists projects_company_idx on public.projects (company_id);
create index if not exists tasks_company_idx on public.tasks (company_id);
create index if not exists photo_reports_company_idx on public.photo_reports (company_id);

-- ---------------------------------------------------------------------------
-- Row Level Security: каждый видит только данные своей компании
-- ---------------------------------------------------------------------------

alter table public.companies enable row level security;
alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.tasks enable row level security;
alter table public.photo_reports enable row level security;

drop policy if exists "company members read company" on public.companies;
create policy "company members read company" on public.companies
  for select to authenticated
  using (id = public.current_company_id());

drop policy if exists "company members read profiles" on public.profiles;
create policy "company members read profiles" on public.profiles
  for select to authenticated
  using (company_id = public.current_company_id());

drop policy if exists "users update own profile" on public.profiles;
create policy "users update own profile" on public.profiles
  for update to authenticated
  using (id = auth.uid())
  with check (id = auth.uid() and company_id = public.current_company_id());

drop policy if exists "company projects" on public.projects;
create policy "company projects" on public.projects
  for all to authenticated
  using (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

drop policy if exists "company tasks" on public.tasks;
create policy "company tasks" on public.tasks
  for all to authenticated
  using (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

drop policy if exists "company photo reports" on public.photo_reports;
create policy "company photo reports" on public.photo_reports
  for all to authenticated
  using (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

-- ---------------------------------------------------------------------------
-- Регистрация компании и вход сотрудников по коду приглашения
-- ---------------------------------------------------------------------------

create or replace function public.create_company(
  p_company_name text,
  p_full_name text,
  p_role text default 'director'
)
returns public.companies
language plpgsql
security definer
set search_path = public
as $$
declare
  new_company public.companies;
begin
  if auth.uid() is null then
    raise exception 'Not authenticated';
  end if;
  if exists (select 1 from public.profiles where id = auth.uid()) then
    raise exception 'User already belongs to a company';
  end if;
  if coalesce(trim(p_company_name), '') = '' then
    raise exception 'Company name is required';
  end if;

  insert into public.companies (name)
  values (trim(p_company_name))
  returning * into new_company;

  insert into public.profiles (id, company_id, full_name, role)
  values (auth.uid(), new_company.id, coalesce(trim(p_full_name), ''), coalesce(p_role, 'director'));

  return new_company;
end;
$$;

create or replace function public.join_company(
  p_invite_code text,
  p_full_name text,
  p_role text default 'siteEngineer'
)
returns public.companies
language plpgsql
security definer
set search_path = public
as $$
declare
  target public.companies;
begin
  if auth.uid() is null then
    raise exception 'Not authenticated';
  end if;
  if exists (select 1 from public.profiles where id = auth.uid()) then
    raise exception 'User already belongs to a company';
  end if;

  select * into target
  from public.companies
  where invite_code = upper(trim(p_invite_code));

  if target.id is null then
    raise exception 'Invalid invite code';
  end if;

  insert into public.profiles (id, company_id, full_name, role)
  values (auth.uid(), target.id, coalesce(trim(p_full_name), ''), coalesce(p_role, 'siteEngineer'));

  return target;
end;
$$;

revoke all on function public.create_company(text, text, text) from public, anon;
revoke all on function public.join_company(text, text, text) from public, anon;
grant execute on function public.create_company(text, text, text) to authenticated;
grant execute on function public.join_company(text, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- Хранилище фотографий (приватный бакет, папка = id компании)
-- ---------------------------------------------------------------------------

insert into storage.buckets (id, name, public)
values ('photo-reports', 'photo-reports', false)
on conflict (id) do nothing;

drop policy if exists "company photos read" on storage.objects;
create policy "company photos read" on storage.objects
  for select to authenticated
  using (
    bucket_id = 'photo-reports'
    and (storage.foldername(name))[1] = public.current_company_id()::text
  );

drop policy if exists "company photos insert" on storage.objects;
create policy "company photos insert" on storage.objects
  for insert to authenticated
  with check (
    bucket_id = 'photo-reports'
    and (storage.foldername(name))[1] = public.current_company_id()::text
  );

drop policy if exists "company photos delete" on storage.objects;
create policy "company photos delete" on storage.objects
  for delete to authenticated
  using (
    bucket_id = 'photo-reports'
    and (storage.foldername(name))[1] = public.current_company_id()::text
  );

-- ---------------------------------------------------------------------------
-- Личные финансы: каждый пользователь видит и меняет только свою запись
-- ---------------------------------------------------------------------------

create table if not exists public.personal_finance (
  user_id uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.personal_finance enable row level security;

drop policy if exists "own finance" on public.personal_finance;
create policy "own finance" on public.personal_finance
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- ---------------------------------------------------------------------------
-- Обновление 2: фото в задачах, телефон сотрудника
-- ---------------------------------------------------------------------------

alter table public.tasks add column if not exists photos text[] not null default '{}';
alter table public.profiles add column if not exists phone text not null default '';
