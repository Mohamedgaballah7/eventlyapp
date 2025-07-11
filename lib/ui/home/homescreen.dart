import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/ui/home/tabs/favourite/favourite_tab.dart';
import 'package:eventlyapproute/ui/home/tabs/home/home_tab.dart';
import 'package:eventlyapproute/ui/home/tabs/map/map_tab.dart';
import 'package:eventlyapproute/ui/home/tabs/profile/profile_tabs.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class Homescreen extends StatefulWidget {
   Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var width;
int selectedIndex=0;
List<Widget>tabs=[
  HomeTab(),MapTab(),FavouriteTab(),ProfileTabs()
];
  @override
  Widget build(BuildContext context) {
     width=MediaQuery.of(context).size.width;
    return Scaffold(

      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
      },
        child: Icon(Icons.add,color: AppColors.whiteColor,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex=index;
              setState(() {

              });
            },
            items: [
              builtBottomNavigationBarItem(
                  index: 0,
                  selectedIconName: AppAssets.iconHomeSelected,
                  unSelectedIconName: AppAssets.iconHome,
                  label: AppLocalizations.of(context)!.home),
              builtBottomNavigationBarItem(
                  index: 1,
                  selectedIconName: AppAssets.iconMapSelected,
                  unSelectedIconName: AppAssets.iconMap,
                  label: AppLocalizations.of(context)!.map),
              builtBottomNavigationBarItem(
                  index: 2,
                  selectedIconName: AppAssets.iconFavouriteSelected,
                  unSelectedIconName: AppAssets.iconFavourite,
                  label: AppLocalizations.of(context)!.favourite),
              builtBottomNavigationBarItem(
                  index: 3,
                  selectedIconName: AppAssets.iconProfileSelected,
                  unSelectedIconName: AppAssets.iconProfile,
                  label: AppLocalizations.of(context)!.profile),
            ]),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({required int index,required String selectedIconName,required String unSelectedIconName,required String label}){
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(selectedIndex==index?selectedIconName:unSelectedIconName),size: width*0.06,),
        label: label,
    );
  }
}
