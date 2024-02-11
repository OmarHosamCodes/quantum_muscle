// ignore_for_file: strict_raw_type

import 'package:quantum_muscle/library.dart';

class ContentModel {
  ContentModel({
    required this.id,
    required this.title,
    required this.contentURL,
    required this.creationDate,
    required this.description,
    required this.likes,
    required this.comments,
  });

  factory ContentModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      ContentModel(
        id: map[idKey] as String,
        title: map[titleKey] as String,
        contentURL: map[contentURLKey] as String,
        creationDate: map[creationDateKey] as Timestamp,
        description: map[descriptionKey] as String,
        likes: map[likesKey] as List,
        comments: map[commentsKey] as Map<String, dynamic>,
      );
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String contentURLKey = 'contentURL';
  static const String creationDateKey = 'creationDate';
  static const String descriptionKey = 'description';
  static const String likesKey = 'likes';
  static const String commentsKey = 'comments';
  static const String modelKey = 'ContentModel';

  String id;
  String title;
  String contentURL;
  Timestamp creationDate;
  String description;
  List likes;
  Map<String, dynamic> comments;

  Map<String, dynamic> toMap() => {
        idKey: id,
        titleKey: title,
        contentURLKey: contentURL,
        creationDateKey: creationDate,
        descriptionKey: description,
        likesKey: likes,
        commentsKey: comments,
      };
}
