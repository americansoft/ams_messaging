import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../widgets/login_signup_btn.dart';
import '../widgets/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: _WelcomeScreenWidget(),
        ),
      ),
    );
  }
}

class _WelcomeScreenWidget extends StatelessWidget {
  const _WelcomeScreenWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
