class FeedEntryModel {
  /// The posts title
  final String title;

  /// The posts body
  final String body;

  /// The source of the post
  final String source;

  /// The date and time of the post
  /// It's used for caching and sorting purposes, make sure to set it!
  final DateTime dateTime;
  const FeedEntryModel(
      {required this.title,
      required this.body,
      required this.source,
      required this.dateTime});
  toJson() => {
        'title': title,
        'body': body,
        'source': source,
        'dateTime': dateTime.millisecondsSinceEpoch,
      };
  FeedEntryModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        source = json['source'],
        dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']);
}
