import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/interface/ICacheWrapper.dart';
import 'package:flutter_simple_updates/logic/FeedRepository.dart';
import 'package:flutter_simple_updates/logic/NotificationQueryService.dart';
import 'package:flutter_simple_updates/widgets/FeedDialog.dart';
import 'package:flutter_simple_updates/abstract/AFeedParsingService.dart';

class NotificationWidget extends StatefulWidget {
  final Icon hasNotificationIcon;
  final Icon noNotificationIcon;
  final AFeedParsingService feedProvider;
  late final NotificationQueryService notificationQueryService;
  final ICacheWrapper cache;
  NotificationWidget(
      {super.key,
      this.noNotificationIcon = const Icon(Icons.notifications),
      this.hasNotificationIcon = const Icon(Icons.notifications_active),
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
          return StreamBuilder(
            initialData: false,
            stream: widget.notificationQueryService.queryForUpdates(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                bool data = snapshot.data!;
                return AnimatedContainer(
                  curve: Curves.easeInOutBack,
                  duration: data
                      ? const Duration(milliseconds: 500)
                      : const Duration(milliseconds: 0),
                  transformAlignment: AlignmentGeometryTween(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .transform(0.5),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => FeedDialog(
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
                          : widget.noNotificationIcon),
                );
              } else if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return const Icon(Icons.warning);
              } else {
                return const SizedBox();
              }
            },
          );
        });
  }
}
