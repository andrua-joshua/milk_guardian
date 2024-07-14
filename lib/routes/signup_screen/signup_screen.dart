import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:milk_analysis/bloc/respository/user_repository/user_repository.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/app_text_input_fields.dart';
import 'package:milk_analysis/util/custom_widget.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});


  @override
  _signupscreenState createState() => _signupscreenState();

}


class _signupscreenState extends State<SignupScreen>{

  bool isLoding = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        
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
              const Text("Signup", style: AppStyle.bigTitleStyle,),
              const SizedBox(height: 30,),
              const Text("UserName", style: AppStyle.deviceCountLabelStyle,),
              const SizedBox(height: 5,),
              TextInputFieldWidget(
                controller: _usernameController, 
                hintText: "username", 
                isObsured: false),

              const SizedBox(height: 20,),
              const Text("Email", style: AppStyle.deviceCountLabelStyle,),
              const SizedBox(height: 5,),
              TextInputFieldWidget(
                controller: _emailController, 
                hintText: "email", 
                isObsured: false),
              
              const SizedBox(height: 20,),
              const Text("Phone", style: AppStyle.deviceCountLabelStyle,),
              const SizedBox(height: 5,),
              TextInputFieldWidget(
                controller: _phoneController, 
                hintText: "Phone", 
                isObsured: false),
              
              const SizedBox(height: 20,),
              const Text("Password", style: AppStyle.deviceCountLabelStyle,),
              const SizedBox(height: 5,),
              DOutlinedTextInputField(
                hintText: "Password", 
                hintTextStyle: AppStyle.normalGreyTextStyle, 
                valueTextStyle: AppStyle.normalBlackTextStyle, 
                borderColor: AppColors.primaryColor, 
                borderRadius: 20, 
                btnHeight: 45, 
                controller: _passwordController),

              const SizedBox(height: 35,),
              !isLoding? ConeredButton(
                label: "Sign up", 
                txtColor: Colors.white, 
                bgColor: Colors.blue, 
                onClick: (){
                  _signup(value);
                }):const Center(child: SizedBox(height: 20, width: 20,child: CircularProgressIndicator(),),),
              const SizedBox(height: 15,),
              ConeredButton(
                label: "Login", 
                txtColor: Colors.white, 
                bgColor: Colors.grey, 
                onClick: (){
                  Navigator.pushNamed(context, RouteGenerator.loginScreen);
                })

            ],
          ),
        ),)),
    );
      },);
  }

  Future<void> _signup(UserProvider userProvider)async{
    setState(() {
      isLoding = true;
    });

    if(_usernameController.text.isEmpty
      || _phoneController.text.isEmpty
      || _emailController.text.isEmpty
      || _passwordController.text.isEmpty
      || _usernameController.text.isEmpty
    ){
      setState(() {
        isLoding = false;
      });

      Fluttertoast.showToast(msg: "Please fill all the fields");
      return;
    }

    final res = await  userProvider.userRepo.signUp(
      username: _usernameController.text, 
      phone: _phoneController.text, 
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
        msg: "Failed to signup");
    }
  }
}