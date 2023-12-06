import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/widgets/FeedDialog.dart';
import 'package:flutter_simple_updates/abstract/AFeedParsingService.dart';

class NotificationWidget extends StatelessWidget {
  final Icon icon;
  final AFeedParsingService feedProvider;
  const NotificationWidget(
      {super.key,
      this.icon = const Icon(Icons.notifications),
      required this.feedProvider});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: feedProvider.parseFeed(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!;
          return IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => FeedDialog(
                          feedEntries: data,
                        ));
              },
              icon: icon);
        } else if (snapshot.hasError) {
          return const Icon(Icons.warning);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
