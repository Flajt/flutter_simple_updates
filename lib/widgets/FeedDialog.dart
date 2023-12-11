import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/interface/IConverter.dart';
import 'package:flutter_simple_updates/logic/FeedRepository.dart';
import 'package:flutter_simple_updates/models/FeedEntryModel.dart';
import 'package:flutter_simple_updates/widgets/FeedDialogTile.dart';

class FeedDialog extends StatelessWidget {
  final FeedRepository feedRepository;
  final IConverter converter;

  /// Text to display if the feed is empty
  final String emptyFeedText;
  const FeedDialog(
      {super.key,
      this.emptyFeedText = "Seems like there are is no data yet",
      required this.converter,
      required this.feedRepository});

  @override
  Widget build(BuildContext context) {
    final listTileTheme = Theme.of(context).listTileTheme;
    final Size size = MediaQuery.of(context).size;
    return Dialog.fullscreen(
        child: SizedBox(
      height: size.height,
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
          FutureBuilder(
            future: feedRepository.getAndSaveFeed(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final feedEntries = snapshot.data as List<FeedEntryModel>;

                return Expanded(
                    child: ListView.builder(
                        itemCount: feedEntries.length,
                        itemBuilder: (context, index) {
                          return FeedDialogTile(
                              converter: converter,
                              feedEntry: feedEntries[index],
                              listTileTheme: listTileTheme);
                        }));
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Expanded(
                  child: Center(
                      child: Text(
                    emptyFeedText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  )),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    ));
  }
}
