
import 'package:ams_messaging/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/avatar.dart';
import '../widgets/icon_buttons.dart';

class ProfileScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) =>  ProfileScreen(),
      );
   const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: Center(
          child: IconBackground(
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'hero-profile-picture',
              child: Avatar.large(url: user?.image),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user?.name ?? 'No name'),
            ),
            const Divider(),
            const _SignOutButton(),
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton();

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() {
      _loading = true;
    });



    try {
      final nav = Navigator.of(context);
      await StreamChatCore.of(context).client.disconnectUser();
      await firebase.FirebaseAuth.instance.signOut();

      nav.pushReplacement(SplashScreen.route);
    } on Exception catch (e, _) {
      //Todo Catch Error
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: _signOut,
            child: const Text('Sign out'),
          );
  }
}
