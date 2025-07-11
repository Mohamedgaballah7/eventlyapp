import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventsItems extends StatelessWidget {
  bool isSelected;
  String eventName;
  Color selectedBorderColor;
  Color unSelectedBorderColor;
  Color selectedBackGroundColor;
  Color unSelectedBackGroundColor;
  TextStyle? selectedTextStyle;
  TextStyle? unSelectedTextStyle;
   EventsItems({super.key,
     required this.isSelected,
     required this.eventName,
     required this.selectedBorderColor,
     required this.unSelectedBorderColor,
     required this.selectedBackGroundColor,
     required this.unSelectedBackGroundColor,
     required this.selectedTextStyle,
     required this.unSelectedTextStyle,
   });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height*0.001,horizontal: width*0.02),
      margin: EdgeInsets.symmetric(vertical: height*0.001,horizontal: width*0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(width*0.2),
        border: Border.all(width: 2,
            color:isSelected? selectedBorderColor:unSelectedBorderColor),
        color: isSelected? selectedBackGroundColor:unSelectedBackGroundColor
      ),
      child: Text(eventName,style: isSelected?selectedTextStyle:unSelectedTextStyle),
    );
  }
}
//??AppColors.transparentColor:Theme.of(context).focusColor