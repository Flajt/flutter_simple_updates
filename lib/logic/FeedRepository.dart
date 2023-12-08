import 'package:flutter_simple_updates/flutter_simple_updates.dart';
import 'package:flutter_simple_updates/interface/ICacheWrapper.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';

class FeedRepository {
  final AFeedParsingService feedProvider;
  final ICacheWrapper cache;

  FeedRepository({required this.feedProvider, required this.cache});

  Future<List<FeedEntryModel>> getAndSaveFeed() async {
    if (!cache.hasInit) {
      cache.init();
    }
    try {
      List<FeedEntryModel> recentModels = await feedProvider.parseFeed();
      recentModels.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      List<FeedEntryModel> cachedModels = await cache.retriveAll();
      if (cachedModels.isNotEmpty) {
        cachedModels.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        if (cachedModels.first.dateTime.isAfter(recentModels.first.dateTime)) {
          await cache.putAll(recentModels);
          return recentModels;
        } else {
          return cachedModels;
        }
      } else {
        await cache.putAll(recentModels);
        return recentModels;
      }
    } catch (e) {
      List<FeedEntryModel> cachedModels = await cache.retriveAll();
      cachedModels.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return cachedModels;
    }
  }
}
