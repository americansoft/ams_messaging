import 'package:ams_messaging/features/auth/presentation/widgets/background.dart';
import 'package:flutter/material.dart';

import '../widgets/login_form.dart';
import '../widgets/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: _LoginScreenWidget(),
      ),
    );
  }
}

class _LoginScreenWidget extends StatelessWidget {
  const _LoginScreenWidget();


  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
