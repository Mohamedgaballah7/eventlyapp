import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_styles.dart';

class EventsItemsContainer extends StatelessWidget {
  const EventsItemsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
          margin: EdgeInsets.symmetric(vertical: height*0.001,horizontal: width*0.01),
          height: height*0.3,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius:BorderRadius.circular(width*0.04),
            border: Border.all(color: AppColors.primaryLight,width: 2),
            image: DecorationImage(image: AssetImage(AppAssets.holidayBg),fit: BoxFit.fill)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.015,vertical: height*0.001),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadiusGeometry.circular(width*0.02),
                  ),
                  child:Column(
                    children: [
                      Text('21',style: AppStyles.bold20Primary,),
                      Text('Nov',style: AppStyles.bold16Primary,),
                    ],
                  ),
              ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.01),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadiusGeometry.circular(width*0.02),
                  ),
                  child:Row(
                    children: [
                      Text('This is a Birthday Party ',style: AppStyles.bold14Black,),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: AppColors.primaryLight,))
                    ],
                  )
              )
            ],
          ),
        ),
      ],
    );
  }
}
