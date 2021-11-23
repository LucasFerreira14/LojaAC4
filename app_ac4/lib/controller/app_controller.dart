import 'dart:async';

import 'package:app_ac4/modules/home/home.dart';
import 'package:app_ac4/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';

class ControllerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NasaStore',
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => SplashPage(),
        '/home': (context) => Home(),
      },
    );
  }
}
