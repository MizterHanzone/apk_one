import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work_one/screens/cart_screen.dart';
import 'package:home_work_one/screens/login_screen.dart';
import 'package:home_work_one/screens/main_screen.dart';
import 'package:home_work_one/screens/register_screen.dart';
import 'package:home_work_one/screens/splash_screen.dart';

class AppRoute {
  static const String splashScreen = "";
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String mainScreen = "mainScreen";
  static const String cartScreen = "cartScreen";

  static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case splashScreen:
        return _buildRoute(routeSettings, SplashScreen());
      case loginScreen:
        return _buildRoute(routeSettings, LoginScreen());
      case registerScreen:
        return _buildRoute(routeSettings, RegisterScreen());
      case mainScreen:
        return _buildRoute(routeSettings, MainScreen());
      case cartScreen:
        return _buildRoute(routeSettings, CartScreen());
      default:
        throw RouteException("Route not found!");
    }
  }

  static Route<dynamic> _buildRoute(RouteSettings routeSettings, Widget newScreen) {
    return MaterialPageRoute(settings: routeSettings, builder: (BuildContext context) => newScreen);
  }
}

class RouteException implements Exception {
  String message;

  RouteException(this.message);
}