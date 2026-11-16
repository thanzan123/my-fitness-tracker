# My Fitness Tracker

Mobile-friendly React + TypeScript + Tailwind tracker with editable six-day workouts, checklists, weight/nutrition/cardio logs, weekly review, movement cues, local persistence and optional Supabase auth/sync.

## Run
Use Node 20+ and pnpm: `pnpm install`, then `pnpm dev`. Device-only mode works immediately and saves in the current browser. Export a backup from Profile before clearing browser data.

## Optional Supabase sync
1. Create a Supabase project and run `supabase-schema.sql` in SQL Editor.
2. For local builds, copy `.env.example` to `.env.local`; set `VITE_SUPABASE_URL` and the project's publishable/anon key. For GitHub Pages, set repository Actions variables named `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`; the workflow embeds them in the public build.
3. Add the deployed origin to Supabase Auth allowed redirect URLs.
4. Rebuild/redeploy. In Profile, enter your email to receive a magic sign-in link. The app loads the account row before syncing. RLS restricts each row to its signed-in owner.

Never include a service-role key in a public build. The public anon key is safe only with RLS enabled. Each account stores one JSONB snapshot.

## GitHub Pages
A Pages workflow is included in `.github/workflows/pages.yml`. Set the repository name to `my-fitness-tracker` (or change `vite.config.ts` to match), push the source to its `main` branch, and enable GitHub Pages with GitHub Actions in repository Settings. The workflow publishes `dist/`. Add the resulting Pages URL to Supabase Auth redirects if cloud sync is configured. Without Supabase variables, the hosted app stays device-only.

## Prefilled data
Only profile defaults and the requested workout plan are prefilled. Workout history, weigh-ins, cardio and nutrition start empty; missing data is never inferred.
