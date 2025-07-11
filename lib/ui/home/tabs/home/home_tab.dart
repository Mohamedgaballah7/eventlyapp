import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/ui/home/tabs/home/widgets/events_items.dart';
import 'package:eventlyapproute/ui/home/tabs/home/widgets/events_items_container.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
class HomeTab extends StatefulWidget {
   HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    List<String>eventsNameList=[
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookclub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
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
              Text('mohamed samy',style: AppStyles.bold20White,)
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
              DefaultTabController(length: eventsNameList.length,
                  child: TabBar(
                    isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: AppColors.transparentColor,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,
                      onTap: (index) {
                        selectedIndex=index;
                        setState(() {
                          
                        });
                      },
                      tabs: eventsNameList.map((eventName) {
                        return EventsItems(
                          selectedBorderColor: AppColors.transparentColor,
                            unSelectedBorderColor: Theme.of(context).focusColor,
                            selectedBackGroundColor: Theme.of(context).focusColor,
                            unSelectedBackGroundColor: AppColors.transparentColor,
                            selectedTextStyle: Theme.of(context).textTheme.headlineMedium,
                            unSelectedTextStyle: Theme.of(context).textTheme.headlineSmall,
                            isSelected: selectedIndex==eventsNameList.indexOf(eventName),
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
            child: ListView.separated(
              padding: EdgeInsets.only(top: height*0.02),
                itemBuilder: (context, index) {
              return EventsItemsContainer();
            },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.01,);
                },
                itemCount: eventsNameList.length),
          ),
        ],
      ),
    );
  }
}
