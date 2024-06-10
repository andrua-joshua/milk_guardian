import 'package:flutter/material.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/util/app_styles.dart';

class SplashScreen extends StatelessWidget{
 const SplashScreen({super.key}) ;


 @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then(
      (x){
        Navigator.pushNamed(context, RouteGenerator.homeScreen);
      } );
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/analyz.png")),
                  SizedBox(height: 10,),
                  Text("Guider", style: AppStyle.bigTitleStyle,)
                ],
              )),
            SizedBox(
              child: Row(

              ),
            )
          ],
        )),
    );
  }
}