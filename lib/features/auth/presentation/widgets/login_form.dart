import 'package:ams_messaging/config/constansts/app_colors.dart';
import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:ams_messaging/config/constansts/app_routes.dart';
import 'package:ams_messaging/core/utils/validators.dart';
import 'package:ams_messaging/features/auth/data/models/auth_params.dart';
import 'package:ams_messaging/features/auth/domain/usecases/login_usecase.dart';
import 'package:ams_messaging/features/auth/presentation/widgets/already_have_an_account_check.dart';
import 'package:ams_messaging/service_locator.dart';
import 'package:flutter/material.dart';

import '../pages/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  final kPrimaryColor = AppColors.kPrimaryColor;
  final defaultPadding = AppConstants.defaultPadding;


  void _signIn() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return;

    _formKey.currentState!.save();

    setState(() => _loading = true);

    try {
      final user = await serviceLocator.get<LoginUseCase>().call(
        AuthParams(
          email: _emailController.text.trim(), 
          password:  _passwordController.text.trim())
      );

      if (mounted && user != null) {
        // Navigate to home screen
        await Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }

    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    setState(() => _loading = false);
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _loading?CircularProgressIndicator():
    SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
                  child: Icon(Icons.person),
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
            SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: _signIn,
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
            SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegisterScreen();
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
