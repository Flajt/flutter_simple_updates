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
          child: Column(children: [
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop())),
        Title(
            color:
                textTheme.titleMedium?.color ?? Theme.of(context).primaryColor,
            child: Text(
              feedEntry.title,
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            )),
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: SelectableText(
                feedEntry.body,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ])),
    );
  }
}
