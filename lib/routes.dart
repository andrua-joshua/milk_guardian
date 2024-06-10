import 'package:flutter/material.dart';
import 'package:milk_analysis/routes/home_screen/home_screen.dart';
import 'package:milk_analysis/routes/record_screen/record_screen.dart';
import 'package:milk_analysis/routes/results_screen/result_screen.dart';
import 'package:milk_analysis/routes/splash_screen/splash_screen.dart';

class RouteGenerator{

  static const String homeScreen = "/homeScreen";
  static const String resultScreen = "/resultScreen";
  static const String recordScreen = "/recordScreen";
  static const String splashScreen = "/";



  static Route<dynamic> generate(RouteSettings settings){
    switch(settings.name){
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen());
      case resultScreen:
        return MaterialPageRoute(
          builder: (_) => const ResultScreen());
      case recordScreen:
        return MaterialPageRoute(
          builder: (_) => const RecordScreen());

      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen());
    }
  }
}