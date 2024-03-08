/// A class that provides validation methods for various input fields.
class ValidationController {
  /// Validates a name by checking if it is not empty, matches the
  /// name regex pattern,
  /// and has a length between 2 and 20 characters.
  static bool validateName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return name.isNotEmpty &&
        nameRegex.hasMatch(name) &&
        name.length >= 2 &&
        name.length <= 20;
  }

  /// Validates an email by checking if it is not empty and matches the
  /// email regex pattern.
  static bool validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
    return email.isNotEmpty && emailRegex.hasMatch(email);
  }

  /// Validates a password by checking if it is not empty and matches the
  /// password regex pattern.
  static bool validatePassword(String password) {
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$');
    return password.isNotEmpty && passwordRegex.hasMatch(password);
  }

  /// Validates a bio by checking if it is not empty, matches the bio regex
  /// pattern,
  /// and has a length less than or equal to 250 characters.
  static bool validateBio(String bio) {
    final bioRegex = RegExp(r'^[a-zA-Z\s]+$');
    return bio.isNotEmpty && bioRegex.hasMatch(bio) && bio.length <= 250;
  }

  /// Validates a description by checking if it is not empty, does not
  /// contain any
  /// special characters (<, >, &), and has a length less than or equal to
  /// 500 characters.
  static bool validateDescription(String description) {
    final descriptionRegex = RegExp('[<>&]');
    return description.isNotEmpty &&
        !descriptionRegex.hasMatch(description) &&
        description.length <= 500;
  }

  /// Validates a number by checking if it is not empty and matches the
  /// number regex pattern.
  static bool validateOnlyNumbers(String number) {
    final numberRegex = RegExp(r'^[0-9\/]+$');
    return number.isNotEmpty && numberRegex.hasMatch(number);
  }
}
