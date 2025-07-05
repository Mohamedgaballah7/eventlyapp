import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/onboarding_data_class.dart';
import '../../../providers/app_languages_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_styles.dart';
class OnboardingScreenCustom extends StatefulWidget {
  Onboarding onboarding;
  bool slider;
  bool slider2;
  OnboardingScreenCustom({super.key,required this.onboarding, this.slider=false, this.slider2=false});

  @override
  State<OnboardingScreenCustom> createState() => _OnboardingScreenCustomState();
}

class _OnboardingScreenCustomState extends State<OnboardingScreenCustom> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    // var languageProvider=Provider.of<AppLanguagesProvider>(context);
    // var themeProvider=Provider.of<AppThemeProvider>(context);
    return Column(
      children: [
        Image.asset('assets/images/onboarding_${widget.onboarding.image}.png'),
        SizedBox(height:height*0.03 ,),
        Text(widget.onboarding.title,style: AppStyles.bold20Primary,),
        SizedBox(height:height*0.03 ,),
        Text(widget.onboarding.content,style: Theme.of(context).textTheme.headlineLarge,),
        SizedBox(height:height*0.03 ,),
        // widget.slider?SwitchListTile(
        //   title: Text('Theme Mode'),
        //   value: themeProvider.isDarkMode(),
        //   onChanged: (value) => themeProvider.appTheme=ThemeMode.light,
        // ):SizedBox(),
        // widget.slider2?SwitchListTile(
        //   title: Text('Language'),
        //   value: languageProvider.isEnglish(),
        //   onChanged: (value) {
        //     languageProvider.appLanguage='ar';
        //     setState(() {
        //
        //     });
        //   },
        // ):SizedBox()
      ],
    );
  }
}
