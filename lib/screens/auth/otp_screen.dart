import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  late String phoneNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve passed phone number
    phoneNumber = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  void _verifyOtp() {
    //
    // final otp = _otpController.text.trim();
    // if (otp.length != 6) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please enter a 6-digit OTP')),
    //   );
    //   return;
    // }
    //
    // // Proceed to next screen or verification
    // Navigator.pushReplacementNamed(context, '/profile-setup');
    Navigator.pushReplacementNamed(context, '/profile-setup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.lock, size: 90, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'Code sent to\n$phoneNumber',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
