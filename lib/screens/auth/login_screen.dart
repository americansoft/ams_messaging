import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _submitPhone() {
    // Todo
    //
    // final phone = _phoneController.text.trim();
    // if (phone.isEmpty || phone.length < 10) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please enter a valid phone number')),
    //   );
    //   return;
    // }
    // Navigator.pushNamed(context, '/otp', arguments: phone);
    Navigator.pushNamed(context, '/otp', arguments: 01114834675);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(Icons.phone_android, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 15,
              decoration: InputDecoration(
                prefixText: '+',
                labelText: 'Phone Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitPhone,
              icon: const Icon(Icons.send),
              label: const Text('Send OTP'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
