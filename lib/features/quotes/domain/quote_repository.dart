import 'package:taskstreak/data/database/app_database.dart';

abstract interface class QuoteRepository {
  Stream<List<Quote>> watchAll();
  Stream<List<Quote>> watchFavourites();
  Future<void> setFavourite(String quoteId, bool isFavourite);
}
