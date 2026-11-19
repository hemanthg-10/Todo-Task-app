import 'package:drift/drift.dart';
import 'package:taskstreak/data/database/app_database.dart';
import 'package:taskstreak/features/quotes/domain/quote_repository.dart';

class LocalQuoteRepository implements QuoteRepository {
  LocalQuoteRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Quote>> watchAll() => _db.select(_db.quotes).watch();

  @override
  Stream<List<Quote>> watchFavourites() {
    final query = _db.select(_db.quotes).join([
      innerJoin(_db.favouriteQuotes,
          _db.favouriteQuotes.quoteId.equalsExp(_db.quotes.id)),
    ])..orderBy([OrderingTerm.desc(_db.favouriteQuotes.likedAt)]);
    return query.watch().map((rows) => rows.map((row) => row.readTable(_db.quotes)).toList());
  }

  @override
  Future<void> setFavourite(String quoteId, bool isFavourite) async {
    if (isFavourite) {
      await _db.into(_db.favouriteQuotes).insertOnConflictUpdate(
            FavouriteQuotesCompanion.insert(quoteId: quoteId),
          );
    } else {
      await (_db.delete(_db.favouriteQuotes)
            ..where((f) => f.quoteId.equals(quoteId)))
          .go();
    }
  }
}
