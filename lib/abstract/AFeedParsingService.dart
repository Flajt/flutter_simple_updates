import 'package:flutter_simple_updates/models/FeedEntryModel.dart';

/// Interface for a service that retrieves a list of FeedEntryModels
/// You can build your own by implementing it
abstract class AFeedParsingService {
  /// The trigger is used to identify if a post should be included or not in the list
  final String trigger;
  final String id;

  AFeedParsingService(this.trigger, this.id);
  // Parses your data source and returns a list of FeedEntryModels
  // [id] corresponds to a unique identifier for your data source e.g. username
  Future<List<FeedEntryModel>> parseFeed();
}
