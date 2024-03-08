import 'package:quantum_muscle/library.dart';

/// Utility class for user related operations.
class UserUtil extends Utils {
  /// Searches for users based on the provided search text.
  Future<List<UserModel>> searchUsers(String searchText) async {
    final QuerySnapshot query = await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .where(UserModel.tagsKey, arrayContains: searchText)
        .limit(10)
        .get();

    final users = <UserModel>[];

    for (final doc in query.docs) {
      users.add(UserModel.fromMap(doc.data()! as Map<String, dynamic>));
    }

    return users;
  }
}
