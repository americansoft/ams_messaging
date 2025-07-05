import 'dart:async';

import 'package:flutter/material.dart';
 
import '../config/constansts/app_routes.dart';

class SplashScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleAuthenticatedState();
  }

  Future<void> _handleAuthenticatedState() async {
    final auth = firebase.FirebaseAuth.instance;
    if (!mounted) {
      return;
    }
    listener = auth.authStateChanges().listen((user) async {
      if (user != null) {

        // get Stream user token
        final callable = functions
            .httpsCallable('ext-auth-chat-getStreamUserToken')
            .call();

        final results = await Future.wait([
          callable,
          // delay to show loading indicator
          Future.delayed(const Duration(milliseconds: 700)),
        ]);

        if (!mounted) return;
        // connect Stream user
        final client = StreamChatCore.of(context).client;
        await client.connectUser(
          User(id: user.uid),
          results[0].data,
        );
        debugPrint("Video Stream Created");
        connectVideoStream(user,results[0].data);

        if (!mounted) return;
        // authenticated
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else {
        // delay to show loading indicator
        await Future.delayed(const Duration(milliseconds: 700));

        if (!mounted) return;
        // not authenticated
        Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
