import 'package:eventlyapproute/models/onboarding_data_class.dart';
import 'package:eventlyapproute/ui/boarding/widgets/onboarding_screen.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';

class Onboardingscreen extends StatefulWidget {

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      onDone: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginRouteName);
      },
      showSkipButton: true,
      skip: Container(

          alignment: Alignment.bottomRight,
          child:  Text(AppLocalizations.of(context)!.skip, style:  AppStyles.bold20Primary,)),
      next: const Icon(Icons.arrow_circle_right, color: AppColors.primaryLight,size: 30,),
      done:  Text(AppLocalizations.of(context)!.start, style: AppStyles.bold20Primary),
      dotsDecorator: DotsDecorator(
        color: AppColors.primaryDark,
        activeColor: AppColors.primaryLight,
        size: Size(6, 6),
        activeSize: Size(18, 6),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dotsFlex: 2,
      curve: Curves.easeInOut,
      key: _introKey,
      pages: [
        PageViewModel(
            titleWidget: Image.asset('assets/images/evently_logo.png'),
            bodyWidget: OnboardingScreenCustom(onboarding:
            Onboarding(image: '2', title: AppLocalizations.of(context)!.onboardingtitle2, content: AppLocalizations.of(context)!.onboardingcontent2) ,)
        ),
        PageViewModel(
            titleWidget: Image.asset('assets/images/evently_logo.png'),
            bodyWidget: OnboardingScreenCustom(onboarding:
            Onboarding(image: '3', title: AppLocalizations.of(context)!.onboardingtitle3, content: AppLocalizations.of(context)!.onboardingcontent3) ,)
        ),
        PageViewModel(
            titleWidget: Image.asset('assets/images/evently_logo.png'),
            bodyWidget: OnboardingScreenCustom(onboarding:
            Onboarding(image: '4', title: AppLocalizations.of(context)!.onboardingtitle4, content: AppLocalizations.of(context)!.onboardingcontent4) ,)
        ),
      ],

    );

  }
}
