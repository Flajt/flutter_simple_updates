import 'package:flutter_simple_updates/models/FeedEntryModel.dart';

abstract class ICacheWrapper {
  bool hasInit = false;
  Future<void> init();
  Future<void> save(FeedEntryModel model);
  Future<List<FeedEntryModel>> retriveAll();
  Future<void> clear();
  Future<int> get length;
  Future<void> putAll(List<FeedEntryModel> models);
}
