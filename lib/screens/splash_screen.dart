import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../config/app_routes.dart';
import 'auth/Login/components/video_util.dart';

class SplashScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<firebase.User?> listener;
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
    FirebaseFunctions functions = FirebaseFunctions.instanceFor(region: 'us-central1');
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
    listener.cancel();
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
