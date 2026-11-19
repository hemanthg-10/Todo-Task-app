# TaskStreak — Phase 2 files

This bundle contains the Drift schema, the initial schema-version migration hook,
local repository contracts and implementations, and bundled offline seed data.

## Add these files to the Flutter project

Copy `lib/` and `assets/` into the project root, then replace or merge the root
`pubspec.yaml` and `analysis_options.yaml` with the versions in this bundle.

The package name is `taskstreak`, which matches the Dart imports in the source.
If the project uses a different package name, update those imports consistently.

## Generate Drift code

Drift's `app_database.g.dart` is generated from `lib/data/database/app_database.dart`
and `tables.dart`; do not edit the generated file by hand.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

Call `DatabaseSeeder(database).seedInitialData()` once during app startup. It is
safe to call on subsequent launches: quotes and demo scores are upserted, daily
goal creation does not reset a user's edited goal, and the current-user row is
preserved.

`shared_preferences` holds simple app settings; critical task, goal, streak,
quote, favourite, and leaderboard records live in Drift. For future schema
changes, increment `schemaVersion` and add explicit `onUpgrade` migration steps.

## Quote and avatar attribution

`quotes.json` contains 100 original TaskStreak Studio prompts, written for this
demo dataset. They are not attributed to historical people. All point to the
bundled `taskstreak-placeholder.png`. Replace that image with licensed author
portraits if the quote set is later replaced with attributed quotations; the
presentation should keep an initials fallback for missing assets.

The 18 demo leaderboard profiles and their scores are fictional. Their values
are simulated deterministically from each seed score and the current calendar
week. The current user's row is stored separately with `isCurrentUser = true`.

## Database notes

* Streak dates are local calendar keys (`YYYY-MM-DD`) rather than UTC instants.
* Goal rows use a unique `type`; the seeded daily target is 3. Weekly goal is
  optional and is only stored after the user enables it.
* `weeklyCompleted` and `totalPoints` are additive leaderboard columns to
  support the requested Weekly tab and demo points. All-time ranking remains
  current streak, then total completed, then name.
* Leaderboard UI code should depend on `LeaderboardRepository`. To move to
  Firestore or REST later, implement that interface and switch its provider;
  screens and ranking presentation do not need to know the storage backend.
