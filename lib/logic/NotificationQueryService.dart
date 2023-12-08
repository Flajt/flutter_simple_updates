import 'package:flutter_simple_updates/flutter_simple_updates.dart';
import 'package:flutter_simple_updates/interface/ICacheWrapper.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';

class NotificationQueryService {
  final AFeedParsingService feedProvider;
  final Duration queryInterval;
  final ICacheWrapper cache;
  List<FeedEntryModel> feed = [];
  NotificationQueryService(
      {required this.feedProvider,
      this.queryInterval = const Duration(minutes: 10),
      required this.cache});

  /// Queries your data source for updates every [queryInterval]
  /// Returns true if there are new posts, false otherwise
  Stream<bool> queryForUpdates() async* {
    if (feed.isEmpty) {
      feed = await cache.retriveAll();
    }
    while (true) {
      try {
        final newFeed = await feedProvider.parseFeed();
        if (feed.length != newFeed.length) {
          feed = newFeed;
          yield true;
        } else {
          yield false;
        }

        await Future.delayed(queryInterval);
      } catch (e) {
        yield false;
      }
    }
  }
}
