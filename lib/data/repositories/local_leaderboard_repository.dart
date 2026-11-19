import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/features/leaderboard/domain/leaderboard_repository.dart';

class LocalLeaderboardRepository implements LeaderboardRepository {
  LocalLeaderboardRepository(this._db);
  final AppDatabase _db;

  /// Seed and refresh demo scores once at launch. Values derive from each
  /// fixture's baseline plus the calendar week, so results are deterministic
  /// and won't drift repeatedly when the screen rebuilds.
  Future<void> refreshDemoUsers({DateTime? now}) async {
    final List<dynamic> seed = jsonDecode(
      await rootBundle.loadString('assets/data/demo_leaderboard_users.json'),
    ) as List<dynamic>;
    final int week = _weekNumber(now ?? DateTime.now());
    final List<LeaderboardUsersCompanion> rows = seed.map((dynamic item) {
      final Map<String, dynamic> user = item as Map<String, dynamic>;
      final String id = user['id'] as String;
      final int hash = id.codeUnits.fold<int>(17, (int a, int b) => (a * 31 + b) & 0x7fffffff);
      final int drift = ((week + hash) % 5) - 2;
      final int streak = ((user['currentStreak'] as int) + drift).clamp(0, 9999).toInt();
      final int weekly = (hash + week) % 8;
      final int completed = user['totalCompleted'] as int;
      return LeaderboardUsersCompanion.insert(
        id: id,
        name: user['name'] as String,
        avatarAsset: Value<String>(user['avatarAsset'] as String),
        currentStreak: Value<int>(streak),
        longestStreak: Value<int>((user['longestStreak'] as int).max(streak)),
        totalCompleted: Value<int>(completed + week % 3),
        weeklyCompleted: Value<int>(weekly),
        totalPoints: Value<int>((user['totalPoints'] as int) + week * 3),
      );
    }).toList();
    await _db.batch((Batch batch) {
      batch.insertAllOnConflictUpdate(_db.leaderboardUsers, rows);
    });
  }

  @override
  Stream<List<LeaderboardUser>> watchRanked(LeaderboardPeriod period) {
    final query = _db.select(_db.leaderboardUsers)
      ..orderBy([
        (u) => OrderingTerm.desc(
              period == LeaderboardPeriod.weekly ? u.weeklyCompleted : u.currentStreak,
            ),
        (u) => OrderingTerm.desc(
              period == LeaderboardPeriod.weekly ? u.totalCompleted : u.totalCompleted,
            ),
        (u) => OrderingTerm.asc(u.name),
      ]);
    return query.watch();
  }

  @override
  Future<void> setCurrentUser({
    required String name,
    required String avatarAsset,
    required int currentStreak,
    required int longestStreak,
    required int totalCompleted,
    required int weeklyCompleted,
  }) async {
    await _db.into(_db.leaderboardUsers).insertOnConflictUpdate(
          LeaderboardUsersCompanion.insert(
            id: 'current-user',
            name: name,
            avatarAsset: Value<String>(avatarAsset),
            currentStreak: Value<int>(currentStreak),
            longestStreak: Value<int>(longestStreak),
            totalCompleted: Value<int>(totalCompleted),
            weeklyCompleted: Value<int>(weeklyCompleted),
            totalPoints: Value<int>(totalCompleted * 10),
            isCurrentUser: const Value<bool>(true),
          ),
        );
  }

  int _weekNumber(DateTime date) {
    final DateTime localDate = DateTime(date.year, date.month, date.day);
    return localDate.difference(DateTime(2024, 1, 1)).inDays ~/ 7;
  }
}

extension on int {
  int max(int other) => this > other ? this : other;
}
