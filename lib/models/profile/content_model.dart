// ignore_for_file: strict_raw_type

import 'package:quantum_muscle/library.dart';

/// Represents a content model.
class ContentModel {
  /// Creates a new instance of [ContentModel].
  ContentModel({
    required this.id,
    required this.title,
    required this.contentURL,
    required this.creationDate,
    required this.description,
    required this.likes,
    required this.comments,
  });

  /// Creates a new instance of [ContentModel] from a map.
  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map[idKey] as String,
      title: map[titleKey] as String,
      contentURL: map[contentURLKey] as String,
      creationDate: map[creationDateKey] as Timestamp,
      description: map[descriptionKey] as String,
      likes: map[likesKey] as List,
      comments: map[commentsKey] as Map<String, dynamic>,
    );
  }

  /// The unique identifier of the content.
  final String id;

  /// The title of the content.
  final String title;

  /// The URL of the content.
  final String contentURL;

  /// The creation date of the content.
  final Timestamp creationDate;

  /// The description of the content.
  final String description;

  /// The list of likes for the content.
  final List likes;

  /// The comments for the content.
  final Map<String, dynamic> comments;

  /// The key for the content ID.
  static const String idKey = 'id';

  /// The key for the content title.
  static const String titleKey = 'title';

  /// The key for the content URL.
  static const String contentURLKey = 'contentURL';

  /// The key for the creation date of the content.
  static const String creationDateKey = 'creationDate';

  /// The key for the description of the content.
  static const String descriptionKey = 'description';

  /// The key for the number of likes on the content.
  static const String likesKey = 'likes';

  /// The key for the number of comments on the content.
  static const String commentsKey = 'comments';

  /// The key for the model name.
  static const String modelKey = 'ContentModel';

  /// Converts the [ContentModel] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      titleKey: title,
      contentURLKey: contentURL,
      creationDateKey: creationDate,
      descriptionKey: description,
      likesKey: likes,
      commentsKey: comments,
    };
  }
}
