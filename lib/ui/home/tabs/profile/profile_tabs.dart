
import 'package:eventlyapproute/providers/app_theme_provider.dart';
import 'package:eventlyapproute/ui/home/tabs/profile/language/languages_bottom_sheet.dart';
import 'package:eventlyapproute/ui/home/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_languages_provider.dart';
import '../../../../utils/app_routes.dart';
class ProfileTabs extends StatefulWidget{
  const ProfileTabs({super.key});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvider=Provider.of<AppLanguagesProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height*0.25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(width*0.18)),
        ),
        title: Padding(
          padding:  EdgeInsets.only(bottom: height*0.02),
          child: Row(
            children: [
              Image.asset(AppAssets.RouteLogoProfile),
              SizedBox(width: width*0.025,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Safwat',style: AppStyles.bold20White,),
                  Text('john.route@gmail.com',style: AppStyles.normal16White,),
                ],
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*0.03,horizontal: width*0.028),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: height*0.01,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.035),
                border: Border.all(width: width*0.003,color: AppColors.primaryLight),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.028),
                child: InkWell(
                  onTap: (){
                    showLanguageBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(languageProvider.appLanguage=='en'?
                        AppLocalizations.of(context)!.english:
                    AppLocalizations.of(context)!.arabic
                      ,style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down_sharp,color: AppColors.primaryLight,size: 35,)
                  ],),
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            Text(AppLocalizations.of(context)!.theme,style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: height*0.01,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.035),
                border: Border.all(width: width*0.003,color: AppColors.primaryLight),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.028),
                child: InkWell(
                  onTap: (){
                    showThemeBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(themeProvider.appTheme==ThemeMode.dark?
                      AppLocalizations.of(context)!.dark:
                      AppLocalizations.of(context)!.light,style: AppStyles.bold20Primary,),
                      Icon(Icons.arrow_drop_down_sharp,color: AppColors.primaryLight,size: 35,)
                    ],),
                ),
              ),
            ),
            Spacer(),
            CustomElavatedButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginRouteName, (route) => false,);
            },
                textName: AppLocalizations.of(context)!.logout,
              backgroundColor: AppColors.redColor,
              isIcon: true,
              mainAxisAlignment: MainAxisAlignment.start,
              iconName: Image.asset(AppAssets.iconLogout),
              borderColor: AppColors.transparentColor,
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}