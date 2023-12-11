import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/interface/IConverter.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FeedEntryPage extends StatelessWidget {
  final FeedEntryModel feedEntry;
  final IConverter converter;
  const FeedEntryPage(
      {super.key, required this.feedEntry, required this.converter});

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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: MarkdownWidget(
                  data: converter.convert(feedEntry.body),
                  config: MarkdownConfig(configs: [
                    LinkConfig(
                        onTap: (value) async =>
                            await launchUrl(Uri.parse(value)),
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                  ])),
            ),
          ),
        ),
      ])),
    );
  }
}
