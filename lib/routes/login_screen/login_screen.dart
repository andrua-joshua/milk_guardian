import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:milk_analysis/bloc/respository/user_repository/user_repository.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/app_text_input_fields.dart';
import 'package:milk_analysis/util/custom_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});


  @override
  _loginscreenState createState() => _loginscreenState();

}


class _loginscreenState extends State<LoginScreen>{

  bool isLoding = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder:(context, value, child) {
        
        return Scaffold(
      appBar: AppBar(
        // title: const Text("Signup", style: AppStyle.titleStyle,),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              const Text("Login", style: AppStyle.bigTitleStyle,),
              const SizedBox(height: 30,),
              
              const Text("Email", style: AppStyle.deviceCountLabelStyle,),
              const SizedBox(height: 5,),
              TextInputFieldWidget(
                controller: _emailController, 
                hintText: "Email", 
                isObsured: false),
              
              const SizedBox(height: 20,),
              const Text("Password", style: AppStyle.deviceCountLabelStyle,),
              const SizedBox(height: 5,),
              DOutlinedTextInputField(
                hintText: "Password", 
                hintTextStyle: AppStyle.normalGreyTextStyle, 
                valueTextStyle: AppStyle.normalBlackTextStyle, 
                borderColor: Colors.grey, 
                borderRadius: 15, 
                btnHeight: 45, 
                obscureText: true,
                controller: _passwordController),
              // TextInputFieldWidget(
              //   controller: _passwordController, 
              //   hintText: "Password", 
              //   isObsured: true),

              const SizedBox(height: 35,),
              !isLoding? ConeredButton(
                label: "Login", 
                txtColor: Colors.white, 
                bgColor: Colors.blue, 
                onClick: (){
                  // Navigator.pushNamed(context, RouteGenerator.homeScreen);
                  _login(value);
                }): const Center(child: SizedBox(height: 20, width: 20,child: CircularProgressIndicator(),),),
              const SizedBox(height: 15,),
              ConeredButton(
                label: "Signup", 
                txtColor: Colors.white, 
                bgColor: Colors.grey, 
                onClick: (){
                  Navigator.pushNamed(context, RouteGenerator.signupScreen);
                })

            ],
          ),
        ),)),
    );
      },);
  }


  Future<void> _login(UserProvider userProvider)async{
    setState(() {
      isLoding = true;
    });
    final res = await  userProvider.userRepo.login(
      email: _emailController.text, 
      password: _passwordController.text,
      provider: userProvider);

    setState(() {
      isLoding = false;
    });

    if(res!=null){
      userProvider.user = res;
      userProvider.notifyAll();
      Navigator.pushNamed(context, RouteGenerator.homeScreen);
    }else{
      Fluttertoast.showToast(
        backgroundColor: Colors.black,
        textColor: Colors.red,
        msg: "Login failed");
    }
  }
}