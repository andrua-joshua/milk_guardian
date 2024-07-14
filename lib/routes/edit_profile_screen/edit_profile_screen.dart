import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes/edit_profile_screen/widgets/edit_user_profile_widgets.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/app_text_input_fields.dart';
import 'package:milk_analysis/util/buttons.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget{
  const EditUserProfile({super.key});

  @override
  _editUserProfileState createState () => _editUserProfileState();

}



class _editUserProfileState extends State<EditUserProfile>{

  late final TextEditingController  _emailController;
  late final TextEditingController  _fullNameController;
  late final TextEditingController  _phoneController;
  late final TextEditingController  _passwordController;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  XFile? file;

  bool isLoading = false;


  @override
  void initState() {
    super.initState();

    _emailController  = TextEditingController();
    _phoneController = TextEditingController();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();

    // _emailController.text = UserProvider(
    //   UserRepositoryApi()
    // ).user.email;

    // _phoneController.text = UserProvider(
    //   UserRepositoryApi()
    // ).user!.phone;

    // _fullNameController.text = UserProvider(
    //   UserRepositoryApi()
    // ).user!.name;


  }


  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
          builder: (context, valueU, child)
          => Scaffold(
      backgroundColor: AppColors.softWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.softWhiteColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: SingleChildScrollView(
            child:Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              const Text(
                "Update Account Details",
                style: AppStyle.bigBoldPrimaryTextStyle,
              ),
              const SizedBox(height: 10,),
              const Text(
                "Make sure to pass the right values here",
                style: AppStyle.normalBlackTextStyle,
              ),

              const SizedBox(height: 40,),
              Container(
                constraints: const BoxConstraints.expand(
                  height: 200
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.7,
                    color: AppColors.primaryColor
                  )
                ),
                child: Center(
                  child: UserImageUpdateWidget(
                    imageSelected: (_fl){
                      file = _fl;
                      print("::::::>>>>  Selected file:  ${_fl!.path}");
                    },
                    imgUrl: "imgUrl")),
              ),
              
              const SizedBox(height: 20,),
              const Text(
                "Full Name",
                style: AppStyle.normalBlackTextStyle,
              ),
              DOutlinedTextInputField(
                hintText: "Enter new name", 
                hintTextStyle: AppStyle.normalGreyTextStyle, 
                valueTextStyle: AppStyle.normalBlackTextStyle, 
                borderColor: AppColors.primaryColor, 
                borderRadius: 20, 
                btnHeight: 45, 
                keyboardType: TextInputType.emailAddress,
                controller: _fullNameController),
              const SizedBox(height: 20,),
              const Text(
                "Email",
                style: AppStyle.normalBlackTextStyle,
              ),
              DOutlinedTextInputField(
                hintText: "Enter email", 
                hintTextStyle: AppStyle.normalGreyTextStyle, 
                valueTextStyle: AppStyle.normalBlackTextStyle, 
                borderColor: AppColors.primaryColor, 
                borderRadius: 20, 
                btnHeight: 45, 
                keyboardType: TextInputType.emailAddress,
                controller: _emailController),
              const SizedBox(height: 20,),
              const Text(
                "Phone",
                style: AppStyle.normalBlackTextStyle,
              ),
              DOutlinedTextInputField(
                hintText: "Enter phone", 
                hintTextStyle: AppStyle.normalGreyTextStyle, 
                valueTextStyle: AppStyle.normalBlackTextStyle, 
                borderColor: AppColors.primaryColor, 
                borderRadius: 20, 
                btnHeight: 45, 
                keyboardType: TextInputType.phone,
                controller: _phoneController),

              const SizedBox(height: 20,),
              const Text(
                "Password",
                style: AppStyle.normalBlackTextStyle,
              ),
              DOutlinedTextInputField(
                hintText: "Password", 
                hintTextStyle: AppStyle.normalGreyTextStyle, 
                valueTextStyle: AppStyle.normalBlackTextStyle, 
                borderColor: AppColors.primaryColor, 
                borderRadius: 20, 
                btnHeight: 45, 
                controller: _passwordController),

              const SizedBox(height: 30,),              
              isLoading? const Center(
                    child:SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                  ))
                  :DSolidButton(
                label: "Save Changes", 
                btnHeight: 45, 
                bgColor: AppColors.primaryColor, 
                borderRadius: 20, 
                textStyle: AppStyle.normalBlackTextStyle, 
                onClick: (){
                  _save(context, valueU);
                }),

              const SizedBox(height: 30,),              


            ],
          ))),
          )),
    ));
  }


  Future<void> _save(
    BuildContext context,
    UserProvider provider
    )async{

      setState(() {
        isLoading = true;
      });

    ///name
    ///email
    ///password
    ///phone
    
    final name = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;

    if(
      name.isEmpty
      || _phoneController.text.isEmpty
      || _emailController.text.isEmpty
      || _passwordController.text.isEmpty
    ){
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "Please fill all the fields");
      return;
    }

    // if(file==null){
    //   Fluttertoast.showToast(msg: "Select Profile image to upload");
    //   return;
    // }

    final res = await provider.userRepo.updateUser(
      username: name, 
      phone: phone, 
      email: email, 
      password: password, 
      provider: provider);

    if(res!=null){
      provider.user = res;
      provider.notifyAll();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Successfully Update");
    }else{
      Fluttertoast.showToast(msg: "Failed to update user");
    }


  }
}