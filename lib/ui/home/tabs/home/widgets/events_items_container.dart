import 'package:eventlyapproute/models/event.dart';
import 'package:eventlyapproute/providers/user_provider.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/event_list_provider.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../utils/app_styles.dart';

class EventsItemsContainer extends StatelessWidget {
   EventsItemsContainer({super.key,required this.event});
Event event;

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var eventListProvider=Provider.of<EventListProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutes.editEventRouteName,
            arguments: Event(
                image: event.image,
                eventName: event.eventName,
                title: event.title,
                description: event.description,
                dateTime: event.dateTime,
                time: event.time
            ),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
            margin: EdgeInsets.symmetric(vertical: height*0.001,horizontal: width*0.01),
            height: height*0.3,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(width*0.04),
              border: Border.all(color: AppColors.primaryLight,width: 2),
              image: DecorationImage(image: AssetImage(event.image),fit: BoxFit.fill)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: width*0.015,vertical: height*0.001),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadiusGeometry.circular(width*0.02),
                        ),
                        child:Column(
                          children: [
                            Text('${event.dateTime.day}',style: AppStyles.bold20Primary,),
                            Text(DateFormat('MMM').format(event.dateTime),style: AppStyles.bold16Primary,),
                          ],
                        ),
                    ),
                    IconButton(
                      onPressed: () {
                        eventListProvider.deleteSpecificEventFromFireStore(event, context, userProvider.currentUser!.id);

                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.redColor,
                      ),
                    ),
                  ],
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
                        Text(event.title,style: AppStyles.bold14Black,),
                        Spacer(),
                        IconButton(onPressed: (){
                          eventListProvider.updateIsFavourite(event, context,userProvider.currentUser!.id);
                        },
                            icon:event.isFavourite==true?Icon(Icons.favorite,color: AppColors.primaryLight,):
                            Icon(Icons.favorite_border_outlined,color: AppColors.primaryLight,)
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
