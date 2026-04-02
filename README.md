# Flutter + Supabase app template

Starter Flutter app with **Supabase** (email auth, per-user data, RLS) and **Riverpod**. It includes a sample **tasks** feature you can replace with your own domain.

## Features

- **Supabase** — Email/password sign up, login, logout; per-user task CRUD; row level security so users only see their own rows.
- **Riverpod** — Auth state, async task list/detail providers with loading and error handling.

## Use this template

1. Clone the repository (or use GitHub “Use this template”).
2. Copy [`.env.example`](.env.example) to `.env.override` and set `SUPABASE_URL` and `SUPABASE_ANON_KEY` from your Supabase project (**Project Settings → API**). The committed [`.env`](.env) holds empty placeholders; `.env.override` is gitignored and overrides them at runtime.
3. In the Supabase dashboard, enable **Email** under Authentication → Providers if needed.
4. Run the SQL in [`supabase/schema.sql`](supabase/schema.sql) in the Supabase SQL Editor to create the `tasks` table and policies.
5. From the project root: `flutter pub get`, then `flutter run`.

### Replacing the sample feature

Rename and adapt the `lib/task/` module, the `tasks` table and RLS in SQL, and the Supabase calls in `task_provider.dart` to match your app. The `lib/auth/` and `lib/core/` layout is a reasonable place to keep shared pieces.

## Requirements

- Flutter SDK matching `pubspec.yaml` (`environment.sdk`).
- A Supabase project.

## Development

```sh
flutter pub get
flutter run
```
