import 'package:ams_messaging/config/constansts/app_colors.dart';
import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:ams_messaging/config/constansts/app_routes.dart';
import 'package:ams_messaging/core/network/http_results.dart';
import 'package:ams_messaging/core/utils/validators.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/usecases/register_usecase.dart';
import 'package:ams_messaging/service_locator.dart';
import 'package:flutter/material.dart';

import '../pages/login_screen.dart';
import 'already_have_an_account_check.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final kPrimaryColor = AppColors.kPrimaryColor;
  final defaultPadding = AppConstants.defaultPadding;

  bool _loading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      await serviceLocator.get<RegisterUseCase>().call(
          AuthParams(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        ).then((res) async =>{
          if(mounted){
            if (res is ResultSuccess) {
              await Navigator.of(context).pushReplacementNamed(AppRoutes.profileSetup)
              }
          else if (res is ResultError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              res.error?.response?.data["message"] ?? ""
              )),
          )
        }
        }

        });
        // Navigate to home screen

      } 
      setState(() {
        _loading = false;
      });
    }
  


  String? _emailInputValidator(String? value) {
    return Validators.emailInputValidator(value);
  }

  String? _passwordInputValidator(String? value) {
    return Validators.passwordInputValidator(value);
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

