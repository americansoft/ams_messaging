import 'package:ams_messaging/config/app_theme.dart';
import 'package:ams_messaging/routes/route_generator.dart';

import 'package:ams_messaging/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';


import 'app.dart';
import 'firebase_options.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final client = StreamChatClient(streamKey);


  runApp(
      MyApp(
        client: client,
        appTheme: AppTheme(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.client,
    required this.appTheme,
  });

  final StreamChatClient client;
  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: GlobalStreamChatLocalizations.delegates,
      title: 'Ams Messaging',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().light,
      darkTheme: AppTheme().dark,
      themeMode: ThemeMode.system,
      builder: (context, child) => StreamChat(
        client: client,
        streamChatThemeData:
        StreamChatThemeData.fromTheme(ThemeData.light()),
        child: child!,
      ),
      home: SplashScreen(),
    );
  }
}

