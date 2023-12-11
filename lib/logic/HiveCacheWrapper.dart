import 'dart:io';

import 'package:flutter_simple_updates/interface/ICacheWrapper.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';

/// A wrapper for [hive] cache implemented with [stash]
class HiveCacheWrapper implements ICacheWrapper {
  Cache? _cacheStore;

  /// Amount of maximum entries in the cache
  final int cacheMaxEntries;

  ///Path for storing the cache
  final String? storagePath;

  ///Name for scoping the cache
  final String name;

  HiveCacheWrapper(
      {this.cacheMaxEntries = 20, this.storagePath, this.name = "feed"});

  @override
  Future<void> init() async {
    Directory? dir;
    hasInit = true;
    if (storagePath == null) {
      dir = await getApplicationSupportDirectory();
    }
    final store =
        await newHiveDefaultCacheStore(path: storagePath ?? dir!.path);
    _cacheStore = await store.cache<FeedEntryModel>(
      name: name,
      maxEntries: cacheMaxEntries,
      fromEncodable: (json) => FeedEntryModel.fromJson(json),
      sampler: const FullSampler(),
      evictionPolicy: const FifoEvictionPolicy(),
    );
  }

  @override
  Future<void> save(FeedEntryModel model) async {
    assert(_cacheStore != null, "You need to run init first!");
    await _cacheStore!.put(model.title, model);
  }

  @override
  Future<List<FeedEntryModel>> retriveAll() async {
    assert(_cacheStore != null);
    final feedEntries = <FeedEntryModel>[];
    final keys = await _cacheStore!.keys;
    for (final key in keys) {
      final value = await _cacheStore!.get(key);
      if (value != null) {
        feedEntries.add(value);
      }
    }
    return feedEntries;
  }

  @override
  Future<void> clear() async {
    assert(_cacheStore != null);
    await _cacheStore!.clear();
  }

  @override
  Future<int> get length async {
    assert(_cacheStore != null);
    return await _cacheStore!.size;
  }

  @override
  Future<void> putAll(List<FeedEntryModel> models) async {
    assert(_cacheStore != null);
    for (final model in models) {
      await _cacheStore!.put(model.title, model);
    }
  }

  @override
  bool hasInit = false;
}
