
class Valid {
  static String? validateEmpty(String? fieldName, String? value)  {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if(value == null || value.isEmpty) {
      return 'Username is required.';
    } else if (value.contains(' ')) {
      return 'Invalid Username.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if(value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRepExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRepExp.hasMatch(value)) {
      return "Invalid email address.";
    }

    return null;
  }

  static String? validatePassword(String? value)  {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    //Password Length
    if (value.length < 8){
      return 'Password must be 8 characters long';
    }

    // Uppercase
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Special Characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty)  {
      return 'Phone number is required.';
    }

    final phoneRegExp = RegExp(r'^\d{11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid Phone number';
    }

    return null;
  }
}