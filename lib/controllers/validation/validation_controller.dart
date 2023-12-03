class ValidationController {
  static bool validateName(String name) {
    return name.isNotEmpty && name.length >= 2 && name.length <= 20;
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
}
