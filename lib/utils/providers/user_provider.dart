import '/library.dart';

final userProvider = StreamProvider.family<UserModel, String>(
  (ref, id) async* {
    Map<String, dynamic> data = await Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(id)
        .snapshots()
        .map((event) => event.data()!)
        .first;
    yield UserModel.fromMap(data);
  },
);
final userTypeProvider = StateProvider<UserType>((ref) => UserType.trainee);
