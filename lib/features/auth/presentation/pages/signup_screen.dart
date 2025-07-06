import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../widgets/sign_up_top_image.dart';
import '../widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: _SignupScreenWidget()
      ),
    );
  }
}

class _SignupScreenWidget extends StatelessWidget {
  const _SignupScreenWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignUpScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocialSignUp()
      ],
    );
  }
}
