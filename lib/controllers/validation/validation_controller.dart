class ValidationController {
  static bool validateName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return name.isNotEmpty &&
        nameRegex.hasMatch(name) &&
        name.length >= 2 &&
        name.length <= 20;
  }

  static bool validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
    return email.isNotEmpty && emailRegex.hasMatch(email);
  }

  static bool validatePassword(String password) {
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$');
    return password.isNotEmpty && passwordRegex.hasMatch(password);
  }

  static bool validateBio(String bio) {
    final bioRegex = RegExp(r'^[a-zA-Z\s]+$');
    return bio.isNotEmpty && bioRegex.hasMatch(bio) && bio.length <= 250;
  }

  static bool validateDescription(String description) {
    final descriptionRegex = RegExp(r'[<>&]');
    return description.isNotEmpty &&
        !descriptionRegex.hasMatch(description) &&
        description.length <= 500;
  }

  static bool validateOnlyNumbers(String number) {
    final numberRegex = RegExp(r'^[0-9\/]+$');
    return number.isNotEmpty && numberRegex.hasMatch(number);
  }
}
