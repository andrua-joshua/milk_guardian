import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/custom_widget.dart';

class OTPScreen extends StatefulWidget{
  const OTPScreen({super.key});

  @override
  _otpscreenState createState () => _otpscreenState();

}


class _otpscreenState extends State<OTPScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Text("Enter OTP", style: AppStyle.titleStyle,),
                SizedBox(height: 5,),
                const Text("Enter the  OTP code sent to your email for verification.", style: AppStyle.deviceCountLabelStyle),
                OtpTextField(
                  numberOfFields: 6,

                ),
                SizedBox(height: 100,),
                // ConeredButton(
                //   label: "Verify", 
                //   txtColor: Colors.white, 
                //   bgColor: AppColor, onClick: onClick)
              ],
            ),
          ),)),
    );
  }
}