import 'package:flutter/material.dart';
import 'package:milk_analysis/routes/edit_profile_screen/edit_profile_screen.dart';
import 'package:milk_analysis/routes/home_screen/home_screen.dart';
import 'package:milk_analysis/routes/login_screen/login_screen.dart';
import 'package:milk_analysis/routes/record_screen/record_screen.dart';
import 'package:milk_analysis/routes/results_screen/result_screen.dart';
import 'package:milk_analysis/routes/signup_screen/signup_screen.dart';
import 'package:milk_analysis/routes/splash_screen/splash_screen.dart';
import 'package:milk_analysis/bloc/modules/record_module.dart';
import 'package:milk_analysis/routes/statistics_screen/statistics_screen.dart';
import 'package:milk_analysis/routes/user_profile_screen/user_profile_screen.dart';

class RouteGenerator{

  static const String homeScreen = "/homeScreen";
  static const String resultScreen = "/resultScreen";
  static const String recordScreen = "/recordScreen";
  static const String splashScreen = "/";
  static const String signupScreen = "/signupScreen";
  static const String loginScreen = "/loginScreen";

  static const String editProfileScreen = "/editProfileScreen";
  static const String profileScreen = "/profileScreen";
  static const String reportScreen = "/reportScreen";



  static Route<dynamic> generate(RouteSettings settings){
    switch(settings.name){
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen());
      case resultScreen:
        return MaterialPageRoute(
          builder: (_) => const ResultScreen());
      case reportScreen:
        return MaterialPageRoute(
          builder: (_) => const StatisticsScreen());
      case editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const EditUserProfile());
      case profileScreen:
        return MaterialPageRoute(
          builder: (_) => const SimpleProfileScreen());
      case recordScreen:
        final record = settings.arguments as Record;
        return MaterialPageRoute(
          builder: (_) => RecordScreen(record: record,));

      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen());

      case signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen());

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen());
    }
  }
}