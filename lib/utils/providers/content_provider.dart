import 'package:quantum_muscle/library.dart';

/// Provider for the content
final contentProvider =
    StreamProvider.family<List<ContentModel>, String>((ref, id) async* {
  final contentModelList = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(id)
      .collection(DBPathsConstants.contentPath)
      .snapshots()
      .map(
        (contents) => contents.docs
            .map((content) => ContentModel.fromMap(content.data()))
            .toList(),
      );
  yield* contentModelList;
});
