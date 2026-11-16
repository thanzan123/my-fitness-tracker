-- Run in Supabase SQL Editor. One private JSONB snapshot per signed-in user.
create table if not exists public.fitness_data (user_id uuid primary key references auth.users(id) on delete cascade,payload jsonb not null default '{}'::jsonb,updated_at timestamptz not null default now());
alter table public.fitness_data enable row level security;
drop policy if exists "Users manage their own fitness data" on public.fitness_data;
create policy "Users manage their own fitness data" on public.fitness_data for all to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);
grant select,insert,update,delete on public.fitness_data to authenticated;
