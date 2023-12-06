import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/widgets/FeedDialog.dart';

class NotificationWidget extends StatelessWidget {
  final Icon icon;
  const NotificationWidget(
      {super.key, this.icon = const Icon(Icons.notifications)});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const FeedDialog(
                    feedEntries: [],
                  ));
        },
        icon: icon);
  }
}
