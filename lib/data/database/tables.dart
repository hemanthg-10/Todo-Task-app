import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => text().withDefault(const Constant('General'))();
  TextColumn get priority => text().withDefault(const Constant('medium'))();
  DateTimeColumn get startAt => dateTime().nullable()();
  DateTimeColumn get dueAt => dateTime()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get repeatRule => text().withDefault(const Constant('none'))();
  IntColumn get reminderLeadMinutes => integer().withDefault(const Constant(15))();
  BoolColumn get alarmEnabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text().withLength(min: 1, max: 16).unique()();
  IntColumn get targetCount => integer()();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

class Streaks extends Table {
  // ISO-8601 local calendar date (YYYY-MM-DD), deliberately not a UTC instant.
  TextColumn get date => text().withLength(min: 10, max: 10)();
  IntColumn get tasksCompleted => integer().withDefault(const Constant(0))();
  BoolColumn get goalMet => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {date};
}

class Quotes extends Table {
  TextColumn get id => text()();
  TextColumn get quoteText => text()();
  TextColumn get author => text()();
  TextColumn get authorImageAsset => text().withDefault(const Constant(''))();
  TextColumn get category => text().withDefault(const Constant('general'))();

  @override
  Set<Column> get primaryKey => {id};
}

class FavouriteQuotes extends Table {
  TextColumn get quoteId => text().references(Quotes, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get likedAt => dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {quoteId};
}

class LeaderboardUsers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get avatarAsset => text().withDefault(const Constant(''))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get totalCompleted => integer().withDefault(const Constant(0))();
  BoolColumn get isCurrentUser => boolean().withDefault(const Constant(false))();
  // Additional fields let the offline Weekly tab rank real and demo users.
  IntColumn get weeklyCompleted => integer().withDefault(const Constant(0))();
  IntColumn get totalPoints => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}


