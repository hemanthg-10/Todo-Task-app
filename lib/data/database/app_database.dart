import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Tasks,
  Goals,
  Streaks,
  Quotes,
  FavouriteQuotes,
  LeaderboardUsers,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Increment this for every schema change and add an explicit migration below.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
        },
        onUpgrade: (Migrator migrator, int from, int to) async {
          // Version 1 is the initial schema. Add `if (from < 2)` migrations
          // here when schemaVersion is raised; never delete user data silently.
          if (from < 1 && to >= 1) {
            await migrator.createAll();
          }
        },
        beforeOpen: (OpeningDetails details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory documents = await getApplicationDocumentsDirectory();
    final File file = File(p.join(documents.path, 'taskstreak.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
