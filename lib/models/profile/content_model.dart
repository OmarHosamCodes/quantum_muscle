import 'package:quantum_muscle/library.dart';

class ContentModel {
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
        id: map[idKey],
        title: map[titleKey],
        contentURL: map[contentURLKey],
        creationDate: map[creationDateKey],
        description: map[descriptionKey],
        likes: map[likesKey],
        comments: map[commentsKey],
      );

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
