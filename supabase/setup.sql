-- Run in a dedicated CreatorOS Supabase project, never an unrelated app database.
begin;
create table if not exists public.creatoros_backups (
 owner_id uuid primary key references auth.users(id) on delete cascade,
 revision bigint not null check (revision >= 1),
 payload jsonb not null check (jsonb_typeof(payload) = 'object' and octet_length(payload::text) <= 6000000 and payload->>'version' = '1'),
 updated_at timestamptz not null default now()
);
alter table public.creatoros_backups enable row level security;
revoke all on public.creatoros_backups from public, anon, authenticated;
grant select, insert, update on public.creatoros_backups to authenticated;
create policy "creatoros_select_own" on public.creatoros_backups for select to authenticated
 using ((select auth.uid()) = owner_id and coalesce((select (auth.jwt()->>'is_anonymous')::boolean),false) = false);
create policy "creatoros_insert_own" on public.creatoros_backups for insert to authenticated
 with check ((select auth.uid()) = owner_id and coalesce((select (auth.jwt()->>'is_anonymous')::boolean),false) = false);
create policy "creatoros_update_own" on public.creatoros_backups for update to authenticated
 using ((select auth.uid()) = owner_id and coalesce((select (auth.jwt()->>'is_anonymous')::boolean),false) = false)
 with check ((select auth.uid()) = owner_id and coalesce((select (auth.jwt()->>'is_anonymous')::boolean),false) = false);
commit;
-- Verify RLS and privileges, then test two confirmed Auth users: own row succeeds,
-- other owner's row is invisible, anon is denied, stale revision update affects zero rows.
