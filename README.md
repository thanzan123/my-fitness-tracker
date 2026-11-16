# My Fitness Tracker

A mobile-friendly React + TypeScript tracker with editable six-day workouts, checklists, weight/nutrition/cardio logs, weekly review, movement cues, local persistence and optional Supabase sign-in/cloud sync.

## Run locally

Use Node 20+ and pnpm: `pnpm install`, then `pnpm dev`. Device-only mode works without any credentials and saves in the current browser. Export a backup from Profile before clearing browser data.

## Enable Supabase sign-in and cloud sync

The app uses email magic links and stores a private JSON snapshot per authenticated user in Supabase. The anon/publishable key is embedded in the browser build, so the table's row-level security is essential.

1. Create or select your Supabase project. In its SQL Editor, run [`supabase-schema.sql`](./supabase-schema.sql).
2. Copy the project's **Project URL** and **publishable key** (or legacy `anon` key). Never use or publish a `service_role` key.
3. For a local build, copy `.env.example` to `.env.local` and set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. Restart the dev server after changing environment variables.
4. For the hosted site, open GitHub repository **Settings → Secrets and variables → Actions → Variables** and create repository variables named exactly `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. These are public client configuration, not secrets; do not put a service-role key there. The Pages workflow reads these variables on each build.
5. In Supabase **Authentication → URL Configuration**, set the Site URL to `https://thanzan123.github.io/my-fitness-tracker/` and add that same URL under Redirect URLs. If using a different deployment URL, use that exact origin/path instead.
6. Redeploy by pushing a commit to `main` or running the Pages workflow from GitHub Actions. In the app, open Profile, enter the email address for the account and request the sign-in link. Open the link in the same browser where the app is hosted.

On sign-in, the app loads the account's cloud record before enabling writes, then merges local-only history into the cloud snapshot. If loading the cloud record fails, writes are paused so an inaccessible cloud copy is not overwritten. Local browser data remains available and is also exported with Profile → Export backup. Separate browser-local snapshots are kept per signed-in account; a different account will not absorb another account's local fitness history.

Supabase email delivery and authentication must be enabled for the project. The live email-link login and cross-device persistence still need verification with a real project URL/key and a successful sign-in. Without both environment variables the hosted app intentionally remains in device-only mode.

## GitHub Pages

The Pages workflow is in `.github/workflows/pages.yml`. It builds `dist/` and deploys on pushes to `main`. Enable GitHub Pages with GitHub Actions in repository Settings. Without Supabase variables, the hosted app remains local-first and device-only.

## Prefilled data

Only profile defaults and the requested workout plan are prefilled. Workout history, weigh-ins, cardio and nutrition start empty; missing data is never inferred.
