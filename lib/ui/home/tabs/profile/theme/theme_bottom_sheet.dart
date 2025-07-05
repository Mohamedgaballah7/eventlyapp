import 'package:eventlyapproute/providers/app_theme_provider.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/app_styles.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.028),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                themeProvider.changeTheme(ThemeMode.dark);
              },
              child:themeProvider.isDarkMode()?
              getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark):
              getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark)),
          SizedBox(height: height*0.02,),
          InkWell(
              onTap: (){
                themeProvider.changeTheme(ThemeMode.light);
              },
              child:!(themeProvider.isDarkMode())?
              getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light):
              getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light)),
        ],
      ),
    );
  }

  Widget getSelectedThemeItem({required String textTheme}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTheme,style: AppStyles.bold20Primary,),
        Icon(Icons.check,size: 35,color: AppColors.primaryLight,)
      ],
    );
  }
  Widget getUnSelectedThemeItem({required String textTheme}){
    return Text(textTheme,style:  Theme.of(context).textTheme.headlineLarge,);
  }
}
