import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/flutter_simple_updates.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group("HiveCacheWrapper", () {
    test("Should evict oldest values first", () async {
      final wrapper = HiveCacheWrapper(
          cacheMaxEntries: 4, storagePath: Directory.systemTemp.path);
      await wrapper.init();
      await wrapper.clear();
      for (int i = 0; i < 4; i++) {
        await wrapper.save(FeedEntryModel(null,
            title: i.toString(),
            body: "test",
            source: "",
            dateTime: DateTime.now()));
      }
      await wrapper.save(FeedEntryModel(null,
          title: "4", body: "test", source: "", dateTime: DateTime.now()));
      await wrapper.save(FeedEntryModel(null,
          title: "5", body: "test", source: "", dateTime: DateTime.now()));
      final entries = await wrapper.retriveAll();
      expect(entries.length, 4);
      expect(entries[0].title, "2");
      expect(entries[1].title, "3");
      expect(entries[2].title, "4");
      expect(entries[3].title, "5");
    });
  });
}
