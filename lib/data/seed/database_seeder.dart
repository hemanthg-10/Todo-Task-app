import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/data/repositories/local_leaderboard_repository.dart';

class DatabaseSeeder {
  DatabaseSeeder(this._db);
  final AppDatabase _db;

  /// Safe to call on every launch. Existing user data and favourites are kept.
  Future<void> seedInitialData() async {
    await _seedQuotes();
    await _seedGoals();
    final leaderboard = LocalLeaderboardRepository(_db);
    await leaderboard.refreshDemoUsers();
    final prefs = await SharedPreferences.getInstance();
    final tasks = await _db.select(_db.tasks).get();
    final now = DateTime.now();
    final weekStart = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final completed = tasks.where((t) => t.isDone).length;
    final weekly = tasks
        .where(
          (t) =>
              t.isDone &&
              t.completedAt != null &&
              !t.completedAt!.isBefore(weekStart),
        )
        .length;
    final days = await _db.select(_db.streaks).get();
    final metDates = days.where((d) => d.goalMet).map((d) => d.date).toSet();
    final currentStreak = _currentStreak(metDates, now);
    final longestStreak = _longestStreak(metDates);
    await leaderboard.setCurrentUser(
      name: prefs.getString('profileName') ?? 'You',
      avatarAsset: prefs.getString('profilePhoto') ?? '',
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalCompleted: completed,
      weeklyCompleted: weekly,
    );
  }

  int _currentStreak(Set<String> metDates, DateTime now) {
    var day = DateTime(now.year, now.month, now.day);
    String key(DateTime value) =>
        '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
    if (!metDates.contains(key(day)))
      day = day.subtract(const Duration(days: 1));
    var count = 0;
    while (metDates.contains(key(day))) {
      count++;
      day = day.subtract(const Duration(days: 1));
    }
    return count;
  }

  int _longestStreak(Set<String> metDates) {
    final dates = metDates.toList()..sort();
    var longest = 0;
    var running = 0;
    DateTime? previous;
    for (final value in dates) {
      final parts = value.split('-').map(int.parse).toList();
      final date = DateTime(parts[0], parts[1], parts[2]);
      running = previous != null && date.difference(previous).inDays == 1
          ? running + 1
          : 1;
      if (running > longest) longest = running;
      previous = date;
    }
    return longest;
  }

  Future<void> _seedQuotes() async {
    final List<dynamic> data =
        jsonDecode(await rootBundle.loadString('assets/data/quotes.json'))
            as List<dynamic>;
    final List<QuotesCompanion> quotes = data.map((dynamic item) {
      final Map<String, dynamic> row = item as Map<String, dynamic>;
      return QuotesCompanion.insert(
        id: row['id'] as String,
        quoteText: row['text'] as String,
        author: row['author'] as String,
        authorImageAsset: Value<String>(row['authorImageAsset'] as String),
        category: Value<String>(row['category'] as String),
      );
    }).toList();
    await _db.batch((Batch batch) {
      batch.insertAllOnConflictUpdate(_db.quotes, quotes);
    });
  }

  Future<void> _seedGoals() async {
    await _db
        .into(_db.goals)
        .insert(
          GoalsCompanion.insert(type: 'daily', targetCount: 3),
          onConflict: DoNothing(),
        );
  }
}
