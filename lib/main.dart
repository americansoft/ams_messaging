import 'package:ams_messaging/config/app_theme.dart';
import 'package:ams_messaging/core/routes/route_generator.dart';
import 'package:ams_messaging/core/service_locator/service_locator.dart';
import 'package:ams_messaging/features/chat/presentation/pages/chat_conversation_page.dart';
import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';


void main(){
  setupServiceLocator();
  runApp(
   MyApp(
      appTheme: AppTheme(),
   )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appTheme,
  });

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      builder: DevicePreview.appBuilder,
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      title: 'Ams Messaging',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().light,
      darkTheme: AppTheme().dark,
      themeMode: ThemeMode.system,
      home: ChatConversationPage(),
      


    );
  }
}

