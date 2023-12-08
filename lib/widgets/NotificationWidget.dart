import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/interface/ICacheWrapper.dart';
import 'package:flutter_simple_updates/interface/IConverter.dart';
import 'package:flutter_simple_updates/logic/FeedRepository.dart';
import 'package:flutter_simple_updates/logic/HTMLtoMarkDownConverter.dart';
import 'package:flutter_simple_updates/logic/NotificationQueryService.dart';
import 'package:flutter_simple_updates/widgets/FeedDialog.dart';
import 'package:flutter_simple_updates/abstract/AFeedParsingService.dart';

/// Widget that can be tapped to show a dialog with the latest feed entries
class NotificationWidget extends StatefulWidget {
  /// Icon to display if there are new notification
  final Icon hasNotificationIcon;

  /// Icon to display if there are no new notification
  final Icon noNotificationIcon;

  /// The feed provider to use
  final AFeedParsingService feedProvider;

  /// The notification query service to use
  late final NotificationQueryService notificationQueryService;

  /// The cache to use
  final ICacheWrapper cache;

  /// The converter to use, defaults to [HTMLtoMarkDownConverter]
  /// The converter is used to convert the body of the feed entry to markdown
  final IConverter converter;
  NotificationWidget(
      {super.key,
      this.noNotificationIcon = const Icon(Icons.notifications),
      this.hasNotificationIcon = const Icon(Icons.notifications_active),
      this.converter = const HTMLtoMarkDownConverter(),
      required this.feedProvider,
      required this.cache}) {
    notificationQueryService =
        NotificationQueryService(feedProvider: feedProvider, cache: cache);
  }

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: widget.cache.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              initialData: false,
              stream: widget.notificationQueryService.queryForUpdates(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  bool data = snapshot.data!;
                  return IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => FeedDialog(
                                  converter: widget.converter,
                                  feedRepository: FeedRepository(
                                      feedProvider: widget.feedProvider,
                                      cache: widget.cache),
                                ));
                        if (data) {
                          setState(() {});
                        }
                      },
                      icon: data
                          ? widget.hasNotificationIcon
                          : widget.noNotificationIcon);
                } else if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return const Icon(Icons.warning);
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        });
  }
}
