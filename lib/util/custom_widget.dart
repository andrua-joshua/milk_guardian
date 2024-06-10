import 'package:flutter/material.dart';
import 'package:milk_analysis/util/app_fontsizes.dart';
import 'package:milk_analysis/util/app_styles.dart';

class ConeredButton extends StatelessWidget{
  final String label;
  final Color bgColor;
  final Color txtColor;
  final TextStyle? textStyles;
  final Function() onClick;

  const ConeredButton({
    required this.label,
    required this.txtColor,
    this.textStyles = const TextStyle(),
    required this.bgColor,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15)
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),

          child: Center(
              child:Text(
                label,
                style: TextStyle(
                  fontSize: AppFontSize.normalFontSize,
                  color: txtColor
                ), )),
        ));
  }
}



class AnalyzeButton extends StatelessWidget{
  final String label;
  final Color bgColor;
  final Color txtColor;
  final TextStyle? textStyles;
  final Function() onClick;

  const AnalyzeButton({
    required this.label,
    required this.txtColor,
    this.textStyles = const TextStyle(),
    required this.bgColor,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15)
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),

          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_exchange),
                  SizedBox(width: 10,),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: AppFontSize.normalFontSize,
                      color: txtColor
                    ))
                ],
              ) ),
        ));
  }
}


class ListedResultWidget extends StatelessWidget{
  final List<String> data;
  const ListedResultWidget({
    required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        data.length , (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 3,
              width: 3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
              ),
              margin: const EdgeInsets.only(top: 10),
            ),
            SizedBox(width: 8,),
            Expanded(
              child:Text(
                data[index],
                style: AppStyle.deviceCountLabelStyle,))
          ],
        ))),
    );
  }
}


class CardedResultWidget extends StatefulWidget{
  final String firstLabel;
  final String secondLabel;
  final String firstValue;
  final String secondValue;
  final Color firstColor;
  final Color secondColor;
  const CardedResultWidget({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstValue,
    required this.secondValue,
    required this.firstColor,
    required this.secondColor
  });

  @override
  _cardedResultWidgetState createState() => _cardedResultWidgetState();
}

class _cardedResultWidgetState extends State<CardedResultWidget>{

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints) {
        double width = constraints.maxWidth*0.4;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width,
              height: 100,
              decoration: BoxDecoration(
                color: widget.firstColor,
                borderRadius: BorderRadius.circular(15)
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10,),
                  Text(widget.firstLabel, style: AppStyle.roomLabelStyle,),
                  Text(widget.firstValue, style: AppStyle.sensorDataStyle,)
                ],
              ),
            ),
            Container(
              width: width,
              height: 100,
              decoration: BoxDecoration(
                color: widget.firstColor,
                borderRadius: BorderRadius.circular(15)
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10,),
                  Text(widget.secondLabel, style: AppStyle.roomLabelStyle,),
                  Text(widget.secondValue, style: AppStyle.sensorDataStyle,)
                ],
              ),
            ),
          ],
        );
      },);
  }
}