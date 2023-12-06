class FeedEntryModel {
  /// The posts title
  final String title;

  /// The posts body
  final String body;

  /// The source of the post
  final String source;

  const FeedEntryModel(
      {required this.title, required this.body, required this.source});
}
