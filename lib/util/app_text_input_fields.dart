import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class DOutlinedTextInputField extends StatefulWidget{

  final String hintText;
  final Color borderColor;
  final double btnHeight;
  final double borderRadius;
  final TextStyle hintTextStyle;
  final TextStyle valueTextStyle;
  final TextEditingController controller;
  bool? obscureText;
  TextInputType? keyboardType;
  String? Function(String?)? validator;

  DOutlinedTextInputField({
    super.key,
    required this.hintText,
    required this.hintTextStyle,
    required this.valueTextStyle,
    required this.borderColor,
    required this.borderRadius,
    required this.btnHeight,
    required this.controller,
    this.obscureText,
    this.validator,
    this.keyboardType
  });

  @override
  _dOutlinedTextInputFieldState createState () => _dOutlinedTextInputFieldState();


}



class _dOutlinedTextInputFieldState extends State<DOutlinedTextInputField>{

    bool isVisible = false;

    @override
    Widget build(BuildContext context) {
      return Container(
        height: widget.btnHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.borderColor,
              width: 1
            )
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: (widget.obscureText??false) && !isVisible,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              suffixIcon: (widget.obscureText??false)
                ?IconButton(
                  onPressed: (){
                    setState(() {
                      isVisible = !isVisible;
                    });
                  }, icon: Icon(isVisible
                      ?Icons.visibility_off: Icons.visibility) ):null 
            ),
          ),
      );
    }

}


class DSolidTextInputField extends StatefulWidget{

  final String hintText;
  final Color bgColor;
  final double btnHeight;
  final double borderRadius;
  final TextStyle hintTextStyle;
  final TextStyle valueTextStyle;
  final TextEditingController controller;
  bool? obscureText;
  TextInputType? keyboardType;
  String? Function(String?)? validator;

  DSolidTextInputField({
    super.key,
    required this.hintText,
    required this.hintTextStyle,
    required this.valueTextStyle,
    required this.bgColor,
    required this.borderRadius,
    required this.btnHeight,
    required this.controller,
    this.obscureText,
    this.validator,
    this.keyboardType
  });

  @override
  _DSolidTextInputFieldState createState () => _DSolidTextInputFieldState();


}



class _DSolidTextInputFieldState extends State<DSolidTextInputField>{

    bool isVisible = false;

    @override
    Widget build(BuildContext context) {
      return Container(
        height: widget.btnHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.bgColor
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: (widget.obscureText??false) && !isVisible,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              suffixIcon: (widget.obscureText??false)
                ?IconButton(
                  onPressed: (){
                    setState(() {
                      isVisible = !isVisible;
                    });
                  }, icon: Icon(isVisible
                      ?Icons.visibility_off: Icons.visibility) ):null 
            ),
          ),
      );
    }

}