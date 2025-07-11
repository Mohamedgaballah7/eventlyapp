import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/ui/widgets/switch_toogle_language.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int selectedThemeIndex = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<AppThemeProvider>(context,listen: false);
      setState(() {
        selectedThemeIndex = themeProvider.appTheme == ThemeMode.light ? 0 : 1;

      });
    });
  }
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
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/evently_logo.png'),
                Image.asset(
                  'assets/images/onboarding_1.png', height: height * 0.4,),
                SizedBox(height: height * 0.015),
                Text(
                  AppLocalizations.of(context)!.onboardingtitle1,
                  style: AppStyles.bold20Primary,
                ),
                SizedBox(height: height * 0.015),
                Text(
                  AppLocalizations.of(context)!.onboardingcontent1,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall,
                ),
                SizedBox(height: height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.language,
                      style: AppStyles.bold20Primary,),
                    SwitchToogleLanguage(),
                  ],
                ),
                SizedBox(height: height * 0.02),

                // Theme Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.theme,
                      style: AppStyles.bold20Primary,),
                    ToggleSwitch(
                      minWidth: width * 0.11,
                      minHeight: height * 0.04,
                      initialLabelIndex: selectedThemeIndex,
                      cornerRadius: 20,

                      borderColor: [AppColors.primaryLight],
                      borderWidth: 2,
                      activeBgColor: [AppColors.transparentColor,],
                      inactiveBgColor: AppColors.transparentColor,
                      totalSwitches: 2,
                      customWidgets: [
                        Container(
                          decoration: BoxDecoration(
                            color: selectedThemeIndex == 0 ? AppColors
                                .primaryLight : AppColors.transparentColor,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4),
                          child: Image.asset(
                            AppAssets.iconLightMode, color: AppColors
                              .greyColor,),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: selectedThemeIndex == 1 ? AppColors
                                .primaryLight : AppColors.transparentColor,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4),
                          child: Image.asset(
                            AppAssets.iconDarkMode, color: AppColors
                              .greyColor,),
                        ),
                      ],
                      onToggle: (index) {
                        changeTheme(
                            index: index!, themeProvider: themeProvider);
                        setState(() {

                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: height * 0.025),
                CustomElavatedButton(onPressed: (){
                  Navigator.of(context).pushReplacementNamed(AppRoutes.onboardingRouteName);
                },
                    textName: AppLocalizations.of(context)!.let_start)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeTheme(
      {required int index, required AppThemeProvider themeProvider}) {
    selectedThemeIndex = index;
    if (index == 0) {
      themeProvider.changeTheme(ThemeMode.light);
    } else {
      themeProvider.changeTheme(ThemeMode.dark);
    }
  }
}
