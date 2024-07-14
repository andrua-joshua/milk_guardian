import 'package:flutter/material.dart';
import 'package:milk_analysis/bloc/respository/records_repository/record_repository_base.dart';
import 'package:milk_analysis/bloc/respository/records_repository/record_repository_local.dart';
import 'package:milk_analysis/bloc/respository/records_repository/records_repository_api.dart';
import 'package:milk_analysis/bloc/respository/user_repository/user_repository_api.dart';
import 'package:milk_analysis/provider/data_provider.dart';
import 'package:milk_analysis/provider/record_provider.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/routes/login_screen/login_screen.dart';
import 'package:milk_analysis/routes/signup_screen/signup_screen.dart';
import 'package:milk_analysis/routes/statistics_screen/statistics_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<RecordProvider>(
        create: (_) => RecordProvider(RecordsRepositoryApi())),
      ChangeNotifierProvider<DataProvider>(
      create:(_)=> DataProvider() ),
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(UserRepositoryApi()))
    ],
    builder: (context, child) => const MyApp(),),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analyzer',
      theme: ThemeData(
            fontFamily: "Lufga",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
      debugShowCheckedModeBanner: false,
      // home: const StatisticsScreen(),
      initialRoute: RouteGenerator.splashScreen,
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
