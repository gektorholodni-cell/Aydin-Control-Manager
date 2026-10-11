-- Обновление 2 (11.10.2026). Выполнить в SQL Editor один раз.

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

alter table public.tasks add column if not exists photos text[] not null default '{}';
alter table public.profiles add column if not exists phone text not null default '';
