-- Обновление 3 (11.10.2026): чаты сотрудников и голосовые сообщения.
-- Выполнить в SQL Editor один раз.

create table if not exists public.chats (
  id text primary key default gen_random_uuid()::text,
  company_id uuid not null default public.current_company_id()
    references public.companies (id) on delete cascade,
  type text not null default 'private',
  title text not null default '',
  member_ids uuid[] not null default '{}',
  admin_id uuid default auth.uid(),
  last_message text not null default '',
  last_message_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.chat_messages (
  id text primary key default gen_random_uuid()::text,
  company_id uuid not null default public.current_company_id()
    references public.companies (id) on delete cascade,
  chat_id text not null references public.chats (id) on delete cascade,
  sender_id uuid not null default auth.uid(),
  type text not null default 'text',
  text text not null default '',
  -- Путь файла в бакете photo-reports: <company_id>/chats/<chat_id>/<file>
  media_path text,
  voice_duration text,
  created_at timestamptz not null default now()
);

create index if not exists chats_company_idx on public.chats (company_id);
create index if not exists chat_messages_chat_idx on public.chat_messages (chat_id, created_at);

alter table public.chats enable row level security;
alter table public.chat_messages enable row level security;

-- Чат видят только его участники из той же компании.
drop policy if exists "chat members read" on public.chats;
create policy "chat members read" on public.chats
  for select to authenticated
  using (company_id = public.current_company_id() and auth.uid() = any (member_ids));

drop policy if exists "company members create chats" on public.chats;
create policy "company members create chats" on public.chats
  for insert to authenticated
  with check (company_id = public.current_company_id() and auth.uid() = any (member_ids));

drop policy if exists "chat members update" on public.chats;
create policy "chat members update" on public.chats
  for update to authenticated
  using (company_id = public.current_company_id() and auth.uid() = any (member_ids))
  with check (company_id = public.current_company_id());

drop policy if exists "chat admin delete" on public.chats;
create policy "chat admin delete" on public.chats
  for delete to authenticated
  using (company_id = public.current_company_id() and admin_id = auth.uid());

drop policy if exists "chat members read messages" on public.chat_messages;
create policy "chat members read messages" on public.chat_messages
  for select to authenticated
  using (
    exists (
      select 1 from public.chats c
      where c.id = chat_id
        and c.company_id = public.current_company_id()
        and auth.uid() = any (c.member_ids)
    )
  );

drop policy if exists "chat members send messages" on public.chat_messages;
create policy "chat members send messages" on public.chat_messages
  for insert to authenticated
  with check (
    sender_id = auth.uid()
    and exists (
      select 1 from public.chats c
      where c.id = chat_id
        and c.company_id = public.current_company_id()
        and auth.uid() = any (c.member_ids)
    )
  );

-- Последнее сообщение в списке чатов обновляется автоматически.
create or replace function public.touch_chat_last_message()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.chats
  set last_message = case new.type
        when 'voice' then 'Голосовое сообщение'
        when 'image' then 'Фото'
        else new.text
      end,
      last_message_at = new.created_at
  where id = new.chat_id;
  return new;
end;
$$;

drop trigger if exists chat_messages_touch_chat on public.chat_messages;
create trigger chat_messages_touch_chat
  after insert on public.chat_messages
  for each row execute function public.touch_chat_last_message();

-- Новые сообщения приходят на телефоны сразу (Realtime).
do $$
begin
  alter publication supabase_realtime add table public.chat_messages;
exception when duplicate_object then null;
end $$;

do $$
begin
  alter publication supabase_realtime add table public.chats;
exception when duplicate_object then null;
end $$;
