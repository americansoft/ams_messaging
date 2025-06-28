import 'package:ams_messaging/config/constants.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../../../config/app_routes.dart';
import '../../Login/login_screen.dart';
import '../../components/already_have_an_account_check.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final auth = firebase.FirebaseAuth.instance;
  final functions = FirebaseFunctions.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final kPrimaryColor = AppColors.kPrimaryColor;
  final defaultPadding = AppConstants.defaultPadding;

  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _loading = false;


  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        // Authenticate with Firebase
        final creds =
        await firebase.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final user = creds.user;
        if (mounted) {
          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User is empty')),
            );
            return;
          }
        }

        // Set Firebase display name and profile picture
        List<Future<void>> futures = [
          creds.user!.updateDisplayName(_nameController.text),
          if (_profilePictureController.text.isNotEmpty)
            creds.user!.updatePhotoURL(_profilePictureController.text)
        ];

        await Future.wait(futures);

        // Create Stream user and get token using Firebase Functions
        final results = await functions
            .httpsCallable('ext-auth-chat-getStreamUserToken')
            .call();

        // Connect user to Stream and set user data
        if (!mounted) return;
        final client = StreamChatCore.of(context).client;
        final streamUser = User(
          id: creds.user!.uid,
          name: _nameController.text,
          image: _profilePictureController.text,
        );
        await client.connectUser(
          streamUser,
          results.data,
        );
        await client.updateUser(streamUser);

        if (!mounted) return;
        // Navigate to home screen
        await Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } on firebase.FirebaseAuthException catch (e) {
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Auth error')),
        );
      } catch (e) {

        //Todo Catch Error
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
      setState(() {
        _loading = false;
      });
    }
  }

  String? _nameInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Not a valid email';
    }
    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (value.length <= 6) {
      return 'Password needs to be longer than 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _profilePictureController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? const Center(child: CircularProgressIndicator())
        : Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
          children: [
                Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
          controller: _nameController,
          validator: _nameInputValidator,
          decoration: InputDecoration(
              hintText: 'name',
            prefixIcon: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Icon(Icons.person),
            ),
          ),
          keyboardType: TextInputType.name,
          autofillHints: const [
            AutofillHints.name,
            AutofillHints.username
          ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: _profilePictureController,
                decoration: InputDecoration(
                    hintText: 'picture URL',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.image),
                  ),
                ),
                keyboardType: TextInputType.url,
              ),
            )
            ,
        SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: _emailController,
              validator: _emailInputValidator,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(

                controller: _passwordController,
                validator: _passwordInputValidator,
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            SizedBox(height: defaultPadding / 2),
            ElevatedButton(
              onPressed: _signUp,
              child: Text("Sign Up".toUpperCase()),
            ),
            SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
                ),
          ),
        );
  }
}

