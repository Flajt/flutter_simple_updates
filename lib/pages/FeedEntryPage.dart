import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';

class FeedEntryPage extends StatelessWidget {
  final FeedEntryModel feedEntry;
  const FeedEntryPage({super.key, required this.feedEntry});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop())),
            Title(
                color: textTheme.titleMedium?.color ??
                    Theme.of(context).primaryColor,
                child: Text(feedEntry.title)),
            SelectableText(feedEntry.body, style: textTheme.bodyLarge)
          ])),
    );
  }
}
