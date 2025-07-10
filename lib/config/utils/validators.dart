class Validators {
    

  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) return 'Phone is required';
    if (!RegExp(r'^\+\d{10,15}$').hasMatch(phone)) return 'Invalid phone format';
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) return 'Name is required';
    if (name.length < 2) return 'Name too short';
    return null;
  }

  static String? validateOtp(String? otp) {
    if (otp == null || otp.length != 6) return 'OTP must be 6 digits';
    return null;
  }

  
  static String? emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegex.hasMatch(value)) {
      return 'Not a valid email';
    }
    return null;
  }

    static String? passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (value.length <= 6) {
      return 'Password needs to be longer than 6 characters';
    }
    return null;
  }

  
}
