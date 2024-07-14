import 'package:flutter/material.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/buttons.dart';
import 'package:provider/provider.dart';

class SimpleProfileScreen extends StatefulWidget{
  const SimpleProfileScreen({super.key});


  @override
  _simpleProfileScreen createState() => _simpleProfileScreen();

}


class _simpleProfileScreen extends State<SimpleProfileScreen>{


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, valueU, child) => 
    Scaffold(
      backgroundColor: AppColors.softWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.softWhiteColor,
        title: const Text("Profile", style: AppStyle.titleBoldPrimaryTextStyle,),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child:  
          valueU.user == null
                ?NoLoggedIn():
            SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(""),
                ),
                const SizedBox(height: 15,),
                
                 Text(
                  valueU.user!.username,
                  style: AppStyle.normalBoldPrimaryTextStyle,
                ),
                const SizedBox(height: 10,),
                Text(
                  valueU.user!.email,
                  style: AppStyle.normalBlackTextStyle,
                ),
                const SizedBox(height: 10,),
                Text(
                  valueU.user!.phone,
                  style: AppStyle.normalGreyTextStyle,
                ),

                const SizedBox(height: 40,),
                DSolidButton(
                  label: "Edit Profile", 
                  btnHeight: 45, 
                  bgColor: AppColors.primaryColor, 
                  borderRadius: 15, 
                  textStyle: AppStyle.normalWhiteTextStyle, 
                  onClick: () => Navigator.pushNamed(context, RouteGenerator.editProfileScreen)),
                const SizedBox(height: 10,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Other Details",
                              style: AppStyle.normalBoldPrimaryTextStyle,
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              height: 3,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: AppColors.primaryColor
                              ),
                            ), 
                            const SizedBox(height: 30,),
                          ],
                        )),
                      const SizedBox(width: 10,),
                    ],
                  ),
                ),
                 
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  child: Column(
                  children: [
                    unitInfo(
                      label: "User name", 
                      value: valueU.user!.username),

                    unitInfo(
                      label: "Email", 
                      value: valueU.user!.email),

                    unitInfo(
                      label: "Phone", 
                      value: valueU.user!.phone)
                  ]),
                    ),
                const SizedBox(height: 15,),
                DOutlinedButton(
                  label: "Logout", 
                  btnHeight: 45, 
                  borderColor: AppColors.primaryColor, 
                  borderRadius: 15, 
                  textStyle: AppStyle.normalBlackTextStyle, 
                  onClick: ()async{
                    valueU.user = null;
                    Navigator.pushNamed(context, RouteGenerator.loginScreen);
                    })

              ],
            ),
          ), )),
    ));
  }


  Widget unitInfo({
    required String label,
    required String value
  })
    => Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              label,
              style: AppStyle.normalBlackTextStyle,
          ),

          const SizedBox(width: 10,),
          Expanded(
            child: Text(
              value,
              style: AppStyle.normalBlackTextStyle,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );

    Widget NoLoggedIn()
    => Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:DSolidButton(
        label: "Login", 
        btnHeight: 45, 
        bgColor: AppColors.primaryColor, 
        borderRadius: 20, 
        textStyle: AppStyle.normalWhiteTextStyle, 
        onClick: ()=> Navigator.pushNamed(
                      context, RouteGenerator.loginScreen))),
    );

}