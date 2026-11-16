-- Run once in the Supabase SQL Editor. Stores one private app snapshot per auth user.
create table if not exists public.fitness_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  payload jsonb not null default '{}'::jsonb check (jsonb_typeof(payload) = 'object'),
  updated_at timestamptz not null default now()
);

alter table public.fitness_data enable row level security;

-- Do not expose rows to anonymous clients; authenticated users can access only their own row.
revoke all on table public.fitness_data from anon, public;
grant select, insert, update, delete on table public.fitness_data to authenticated;

drop policy if exists "Users manage their own fitness data" on public.fitness_data;
create policy "Users manage their own fitness data"
  on public.fitness_data
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
