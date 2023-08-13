import 'package:stock/stock.dart';

const store = Store();

/// {@template store}
/// Offline-first database and file storage
/// {@endtemplate}
class Store {
  /// {@macro store}
  const Store();

  FutureStore get future => const FutureStore();
  StreamStore get stream => const StreamStore();
}

class FutureStore {
  const FutureStore();

  Fetcher<String, List<String>> get futureFetcher => Fetcher.ofFuture(
        (userId) async => [' _api.getUserTweets(userId)'],
      );
}

class StreamStore {
  const StreamStore();

  Fetcher<String, List<String>> get streamFetcher =>
      Fetcher.ofStream((userId) async* {
        yield [' _api.getUserTweets(userId)'];
      });
}
