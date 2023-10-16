import 'package:stock/stock.dart';

class FutureStore {
  const FutureStore();
  final _LocalDatabaseApi _local = const _LocalDatabaseApi();

  /// Fetches new data from the network
  Fetcher<String, List<String>> get futureFetcher => Fetcher.ofFuture(
        (userId) async => [' _api.getUserTweets(userId)'],
      );
  Stock<String, List<String>> get stock => Stock(
        fetcher: futureFetcher,
        sourceOfTruth: _local.sourceOfTruthExample,
      );
}

class StreamStore {
  const StreamStore();
  final _LocalDatabaseApi _local = const _LocalDatabaseApi();

  /// Fetches new data from the network
  Fetcher<String, List<String>> get streamFetcher =>
      Fetcher.ofStream((userId) async* {
        yield [' _api.getUserTweets(userId)'];
      });
  Stock<String, List<String>> get stock => Stock(
        fetcher: streamFetcher,
        sourceOfTruth: _local.sourceOfTruthExample,
      );
}

class _LocalDatabaseApi {
  const _LocalDatabaseApi();

  /// Local database access for endpoint
  SourceOfTruth<String, List<String>> get sourceOfTruthExample =>
      SourceOfTruth<String, List<String>>(
        reader: (userId) => const Stream.empty(),
        writer: (userId, tweets) => Future.value(),
        delete: (userId) => Future.value(), // this is optional
        deleteAll: Future.value, // this is optional
      );
}
