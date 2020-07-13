class MyValidator {

  String emailValidator(value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value.trim())) {
      return 'Email Address is Invalid';
    }
    else {
      return null;
    }
  }

  String password(String value) {
    if (value
        .trim()
        .length < 6) {
      return 'Password must be longer than 6 characters';
    }
    else {
      return null;
    }
  }

}