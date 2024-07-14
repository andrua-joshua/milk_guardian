import 'package:flutter/material.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';

class DRadioOptions extends StatefulWidget{
  final List<String> options;
  final Function(int) selected;
  final Color activeBgColor;
  const DRadioOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.activeBgColor
  });

  @override
  _DRadioOptionsState createState () => _DRadioOptionsState();

}

class _DRadioOptionsState extends State<DRadioOptions>{

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints) {
        double width = constraints.maxWidth*0.35;
        return Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  2, (index) => SizedBox(
                    width: width,
                    child:unitItem(widget.options[index], index))),
              ),
            ),
            // const SizedBox(height: 5,),
            // unitItem(widget.options[2], 2)
          ],
        );
      },);
  }


  Widget unitItem(
    String label,
    int index
  ) => GestureDetector(
    onTap: (){
      widget.selected(index);
      setState(() {
        activeIndex = index;
      });
    },
    child: Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: index== activeIndex? widget.activeBgColor:null,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 1
            )
          ),
          // padding: const EdgeInsets.all(1),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child:Text(
          label,
          style: AppStyle.smallBlackTextStyle,))
      ],
    ),
  );
}



class ImageTitleCard extends StatefulWidget{
  final String imageUrl;
  final String link;
  final String title;
  final TextStyle textStyle;
  final double width;
  final double height;

  const ImageTitleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.textStyle,
    required this.link,
    required this.width,
    required this.height
  });


  @override
  _imageTitleCardState createState() => _imageTitleCardState();

}


class _imageTitleCardState extends State<ImageTitleCard>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: ()=> launchUrl(Uri.parse(widget.link)),
      child: Container(
      width: widget.width,
      height: widget.height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // color: AppColors.softWhiteColor
        border: Border.all(
          color: AppColors.greyColor,
          width: 1
        )
      ),

      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints.expand(
              height: widget.height*0.7,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.imageUrl
                  ))
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:Text(
              widget.title,
              style: widget.textStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,)))
        ],
      ),
    ),
    );
  }
}

class DSections extends StatefulWidget{
  final List<String> options;
  final Color inActiveColor;
  final Color activeColor;
  final TextStyle activeStyle;
  final TextStyle inActiveStyle;
  double borderRadius;
  int activeIndex;
  final Function(int) onSelect;
  DSections({
    super.key,
    required this.options,
    required this.activeColor,
    required this.inActiveColor,
    required this.activeStyle,
    required this.inActiveStyle,
    required this.onSelect,
    this.borderRadius = 15,
    this.activeIndex = 0
  });

  @override
  _dSectionsState createState () => _dSectionsState();


}


class _dSectionsState extends State<DSections>{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.options.length, 
          (x)=> unitItem(
            label: widget.options[x], 
            index: x)),
      ),
    );
  }


  Widget unitItem({
    required String label,
    required int index
  }) => GestureDetector(
    onTap: (){
      widget.onSelect(index);
    },
    child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: index==widget.activeIndex
          ?widget.activeColor: widget.inActiveColor,  
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 6,
      vertical: 4
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: 6,
    ),
    child: Text(
      label,
      style: widget.activeIndex== index?
          widget.activeStyle: widget.inActiveStyle,
    ),
  ),
  );
}



class DGridWidget extends StatelessWidget{
  final List<Widget> children;
  final int colCount;
  const DGridWidget({
    super.key,
    required this.children,
    required this.colCount
  });



  @override
  Widget build(BuildContext context) {

    int leng = children.length;
    int rows = (leng/colCount).round();
    int lastColCount =colCount-  ((colCount*rows)-leng);


    return leng==0?const SizedBox(): Column(
      children: List.generate(
        rows, (row)=>Padding(
          padding:  const EdgeInsets.symmetric(vertical: 10),
          child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            ((row == (rows-1)) && lastColCount>0)
            ? lastColCount: colCount , 
            (col)=> children[col==0? (row+col) : (row+col)+1]),
        ))),
    );
  }


}



class GenderDropdown extends StatefulWidget {
  final TextEditingController genderController;
  final TextStyle hintStyle;
  final TextStyle txtStyle;
  final Color bgColor;
  final double borderRadius;

  const GenderDropdown({
    Key? key,
    required this.genderController,
    this.hintStyle = const TextStyle(color: Colors.black54),
    this.txtStyle = const TextStyle(color: Colors.black),
    this.bgColor = Colors.black54,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      child: DropdownButton<Gender>(
        iconSize: 24,
        isExpanded: true,
        // dropdownColor: AppColors.black,
        value: _selectedGender,
        onChanged: (value) {
          setState(() {
            _selectedGender = value;
            widget.genderController.text = value.toString().split('.').last;
          });
        },
        items: [
          DropdownMenuItem<Gender>(
            value: Gender.Male,
            child: Text(
              'Male',
              style: widget.txtStyle,
            ),
          ),
          DropdownMenuItem<Gender>(
            value: Gender.Female,
            child: Text(
              'Female',
              style: widget.txtStyle,
            ),
          ),
        ],
        style: widget.txtStyle,
        underline: Container(),
        hint: Text(
          'Select Gender',
          style: widget.hintStyle,
        ),
      ),
    );
  }
}

enum Gender { Male, Female, Other }