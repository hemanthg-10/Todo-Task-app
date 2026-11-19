import 'package:taskstreak/data/database/app_database.dart';

enum LeaderboardPeriod { weekly, allTime }

/// UI-facing contract. Replace LocalLeaderboardRepository with a Firestore or
/// REST implementation here later; leaderboard screens keep using this API.
abstract interface class LeaderboardRepository {
  Stream<List<LeaderboardUser>> watchRanked(LeaderboardPeriod period);
  Future<void> setCurrentUser({
    required String name,
    required String avatarAsset,
    required int currentStreak,
    required int longestStreak,
    required int totalCompleted,
    required int weeklyCompleted,
  });
}
