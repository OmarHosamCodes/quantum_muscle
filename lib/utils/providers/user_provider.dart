import '/library.dart';

final userProvider = FutureProvider.family<UserModel, String>(
  (ref, id) async {
    Map<String, dynamic> data = await Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(id)
        .get()
        .then((value) => value.data()!);
    return UserModel.fromMap(data);
  },
);
final userTypeProvider = StateProvider<UserType>((ref) => UserType.trainee);
