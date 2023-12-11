import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/interface/IConverter.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:flutter_simple_updates/pages/FeedEntryPage.dart';

class FeedDialogTile extends StatelessWidget {
  const FeedDialogTile({
    super.key,
    required this.converter,
    required this.feedEntry,
    required this.listTileTheme,
  });

  final IConverter converter;
  final FeedEntryModel feedEntry;
  final ListTileThemeData listTileTheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FeedEntryPage(converter: converter, feedEntry: feedEntry))),
        title: Text(feedEntry.title,
            style: listTileTheme.titleTextStyle?.copyWith(
                overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold)),
        subtitle: Text(feedEntry.subtitle ?? feedEntry.body,
            style: listTileTheme.subtitleTextStyle?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ) ??
                const TextStyle(overflow: TextOverflow.ellipsis)));
  }
}
