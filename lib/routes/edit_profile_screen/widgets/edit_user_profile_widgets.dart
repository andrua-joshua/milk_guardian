import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';

class UserImageUpdateWidget extends StatefulWidget{
  final String imgUrl;
  final Function(XFile?) imageSelected;
  const UserImageUpdateWidget({super.key, required this.imgUrl, required this.imageSelected});

  @override
  _userImageUpdateState createState () => _userImageUpdateState();
}


class _userImageUpdateState extends State<UserImageUpdateWidget>{

  XFile? file;

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width:  100,
      decoration: BoxDecoration(
        color: AppColors.softWhiteColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.7,
          color: AppColors.primaryColor
        ),
        image: isSelected? DecorationImage(
          image: FileImage(File(file!.path)) ):null
      ),
      child: (Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: (){
                showDialog(
                  context: context, 
                  builder:(_)
                   => AlertDialog(
                    insetPadding: const EdgeInsets.all(5),
                    titlePadding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5),
                    
                    title: const Text(
                      "Select Image Source",
                      style: AppStyle.titleBoldPrimaryTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    content: imageSelectionOptions(context),
                   ));
              }, 
              child: const CircleAvatar(
                // radius: ,
                child:Icon(Icons.add_a_photo))),
          )
        ],
      )),
    );
  }

  Widget imageSelectionOptions(BuildContext context)
     =>Container(
      height: 100,
      child: Column(
        children: [
          const Divider(color: AppColors.primaryColor, thickness: 0.6,),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              _pickImageGallery().then(
                (x){
                  Navigator.pop(context);
                }
              );
            }, 
            child: const Text(
              "Select from Gallery",
              style: AppStyle.normalBlackTextStyle,
              )),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              _pickImageCamera().then(
                (x){
                  Navigator.pop(context);
                }
              );

            }, 
            child: const Text(
              "Use Device Camera",
              style: AppStyle.normalBlackTextStyle,)),

        ]
      ),
     );

  Future<void> _pickImageGallery() async{
    final _file = await ImagePicker().pickImage(
      source: ImageSource.gallery);

    setState(() {
      file = _file;
      widget.imageSelected(file);
      isSelected = true;
      // print("::::::>>>>  Selected file:  ${_file!.path}");
    });
  }

  Future<void> _pickImageCamera() async{
    final _file = await ImagePicker().pickImage(
      source: ImageSource.camera);

    setState(() {
      file = _file;
      widget.imageSelected(file);
      isSelected = true;
      // print("::::::>>>>  Selected file:  ${_file!.path}");
      
    });

  }


}

