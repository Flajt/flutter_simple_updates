import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:flutter_simple_updates/pages/FeedEntryPage.dart';

class FeedDialog extends StatelessWidget {
  final List<FeedEntryModel> feedEntries;
  final int subBodyPreviewLength;
  const FeedDialog(
      {super.key, required this.feedEntries, this.subBodyPreviewLength = 15});

  @override
  Widget build(BuildContext context) {
    final listTileTheme = Theme.of(context).listTileTheme;
    return Dialog.fullscreen(
        child: SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: feedEntries.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FeedEntryPage(feedEntry: feedEntries[index]))),
                      title: Text(feedEntries[index].title,
                          style: listTileTheme.titleTextStyle?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(feedEntries[index].body,
                          style: listTileTheme.subtitleTextStyle?.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ) ??
                              const TextStyle(
                                  overflow: TextOverflow.ellipsis)));
                }),
          ),
        ],
      ),
    ));
  }
}
