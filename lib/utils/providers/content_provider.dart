import 'package:quantum_muscle/library.dart';

// final contentProvider =
//     FutureProvider.family<List<ContentModel>, String>((ref, id) async {
//   List<ContentModel> contentModelList = await Utils()
//       .firebaseFirestore
//       .collection(DBPathsConstants.usersPath)
//       .doc(id)
//       .collection(DBPathsConstants.contentPath)
//       .get()
//       .then((value) =>
//           value.docs.map((e) => ContentModel.fromMap(e.data())).toList());
//   return contentModelList;
// });
final contentProvider =
    StreamProvider.family<List<ContentModel>, String>((ref, id) async* {
  final contentModelList = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(id)
      .collection(DBPathsConstants.contentPath)
      .snapshots()
      .map((contents) => contents.docs
          .map((content) => ContentModel.fromMap(content.data()))
          .toList(),);
  yield* contentModelList;
});
