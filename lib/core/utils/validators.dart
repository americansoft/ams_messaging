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
}
