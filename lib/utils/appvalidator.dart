class AppValidator {
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return "Please enter a phone number";
    }
    if (value.length != 10) {
      return "Please enter 10 digit phone number";
    }
    return null;
  }

  String? validateUsername(value) {
    if (value!.isEmpty) {
      return "Please enter username";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }

  String? isEmptyCheck(value) {
    if (value!.isEmpty) {
      return "Please fill the details";
    }
    return null;
  }
}
