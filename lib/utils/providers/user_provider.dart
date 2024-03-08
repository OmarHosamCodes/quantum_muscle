import 'package:quantum_muscle/library.dart';

/// Provider that streams a [UserModel] based on the provided user ID.
final userProvider = StreamProvider.family<UserModel, String>(
  (ref, id) async* {
    final data = await Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(id)
        .snapshots()
        .map((event) => event.data()!)
        .first;
    yield UserModel.fromMap(data);
  },
);

/// Provider that holds the current [UserType].
final userTypeProvider = StateProvider<UserType>((ref) => UserType.trainee);
