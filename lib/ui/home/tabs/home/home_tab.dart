import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/ui/home/tabs/home/widgets/events_items.dart';
import 'package:eventlyapproute/ui/home/tabs/home/widgets/events_items_container.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_routes.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../utils/firebase_utils.dart';
import '../../../../models/event.dart';
import '../../../../providers/event_list_provider.dart';
import '../../../../utils/app_colors.dart';
class HomeTab extends StatefulWidget {
   HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var eventListProvider=Provider.of<EventListProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    eventListProvider.getEventsNameList(context);
    if(eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    return Scaffold(
      appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ),
            backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('welcome back',style: AppStyles.normal16White,),
              Text(userProvider.currentUser!.name,
                style: AppStyles.bold20White,)
            ],),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.brightness_low_sharp,color: AppColors.whiteColor,)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.003,vertical: height*0.004),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadiusGeometry.circular(width*0.02),
              ),
              child:Text('EN',style: AppStyles.bold20Primary,)
            )
          ],
        ),
        bottom: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              )
          ),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: height*0.095,
          title: Column(
            children: [
              Row(
                children: [
                  ImageIcon(AssetImage(AppAssets.iconMap),color: AppColors.whiteColor,),
                  Text('Cairo , Egypt',style: AppStyles.normal16White,),
                ],
              ),
              SizedBox(height: height*0.01,),
              DefaultTabController(length: eventListProvider.eventsNameList.length,
                  child: TabBar(
                    isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: AppColors.transparentColor,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,
                      onTap: (index) {
                        eventListProvider.changeToSelectedIndex(index,userProvider.currentUser!.id);
                      },
                      tabs: eventListProvider.eventsNameList.map((eventName) {
                        return EventsItems(
                          selectedBorderColor: AppColors.transparentColor,
                            unSelectedBorderColor: Theme.of(context).focusColor,
                            selectedBackGroundColor: Theme.of(context).focusColor,
                            unSelectedBackGroundColor: AppColors.transparentColor,
                            selectedTextStyle: Theme.of(context).textTheme.headlineMedium,
                            unSelectedTextStyle: Theme.of(context).textTheme.headlineSmall,
                            isSelected: eventListProvider.selectedIndex==eventListProvider.eventsNameList.indexOf(eventName),
                            eventName: eventName);
                      },).toList()
                  ))
            ],
          ),
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: eventListProvider.filterEventList.isEmpty?
            Center(child: Text(AppLocalizations.of(context)!.no_event,style: AppStyles.bold20Primary,)):
            ListView.separated(
              padding: EdgeInsets.only(top: height*0.02),
                itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(AppRoutes.editEventRouteName);
                },
                  child: EventsItemsContainer(event: eventListProvider.filterEventList[index],));
            },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.01,);
                },
                itemCount: eventListProvider.filterEventList.length),
          ),
        ],
      ),
    );
  }
}
