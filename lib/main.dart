import 'package:flutter/material.dart';
import 'package:home_work_one/routes/app_route.dart';
import 'package:home_work_one/screens/main_screen.dart';
import 'package:home_work_one/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
    );
  }
}
