import 'package:flutter/material.dart';

class DOutlinedButton extends StatelessWidget{
  final String label;
  final Color borderColor;
  final double btnHeight;
  final double borderRadius;
  final TextStyle textStyle;
  final Function onClick;

  const DOutlinedButton({
    super.key,
    required this.label,
    required this.btnHeight,
    required this.borderColor,
    required this.borderRadius,
    required this.textStyle,
    required this.onClick
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onClick(),
      child: Container(
        height: btnHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 1
          )
        ),

        padding:  const EdgeInsets.all(5),  

        child: Center(
          child: Text(
            label,
            style: textStyle,        
          ),
        ),
      ),
    );
  }
}




class DSolidButton extends StatelessWidget{
  final String label;
  final Color bgColor;
  final double btnHeight;
  final double borderRadius;
  final TextStyle textStyle;
  final Function onClick;

  const DSolidButton({
    super.key,
    required this.label,
    required this.btnHeight,
    required this.bgColor,
    required this.borderRadius,
    required this.textStyle,
    required this.onClick
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onClick(),
      child: Container(
        height: btnHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor
        ),

        child: Center(
          child: Text(
            label,
            style: textStyle,        
          ),
        ),
      ),
    );
  }
}