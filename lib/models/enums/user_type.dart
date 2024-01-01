import '/library.dart';

enum UserType { trainer, trainee }

extension UserTypeExtension on UserType {
  String get name {
    switch (this) {
      case UserType.trainer:
        return UserTypeConstants.trainer;
      case UserType.trainee:
        return UserTypeConstants.trainee;
    }
  }
}
