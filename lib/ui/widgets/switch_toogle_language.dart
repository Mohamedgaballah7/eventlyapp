import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../providers/app_languages_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class SwitchToogleLanguage extends StatefulWidget {
  const SwitchToogleLanguage({super.key});

  @override
  State<SwitchToogleLanguage> createState() => _SwitchToogleLanguageState();
}

class _SwitchToogleLanguageState extends State<SwitchToogleLanguage> {
  int selectedLanguageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var languageProvider = Provider.of<AppLanguagesProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: width*0.02),
      child: ToggleSwitch(
        minWidth: width * 0.11,
        minHeight: height * 0.04,
        initialLabelIndex: selectedLanguageIndex,
        cornerRadius: 20,

        borderColor: [AppColors.primaryLight],
        borderWidth: 2,
        activeBgColor: [AppColors.transparentColor,],
        inactiveBgColor: AppColors.transparentColor,
        totalSwitches: 2,
        customWidgets: [
          Container(
            decoration: BoxDecoration(
              color: selectedLanguageIndex == 0 ? AppColors
                  .primaryLight : AppColors.transparentColor,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(4),
            child: Image.asset(AppAssets.iconUsFlag,),
          ),
          Container(
            decoration: BoxDecoration(
              color: selectedLanguageIndex == 1 ? AppColors
                  .primaryLight : AppColors.transparentColor,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(4),
            child: Image.asset(AppAssets.iconEgyFlag,),
          ),
        ],
        onToggle: (index) {
          changeLanguage(
              index: index!, languageProvider: languageProvider);
          setState(() {

          });
        },
      ),
    );
  }
  void changeLanguage(
      {required int index, required AppLanguagesProvider languageProvider}) {
    selectedLanguageIndex = index;
    if (index == 0) {
      languageProvider.changeLanguage('en');
    } else {
      languageProvider.changeLanguage('ar');
    }
  }
}
