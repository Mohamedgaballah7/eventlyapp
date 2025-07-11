import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/onboarding_data_class.dart';
import '../../../providers/app_languages_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_styles.dart';
class OnboardingScreenCustom extends StatefulWidget {
  Onboarding onboarding;
  OnboardingScreenCustom({super.key,required this.onboarding});

  @override
  State<OnboardingScreenCustom> createState() => _OnboardingScreenCustomState();
}

class _OnboardingScreenCustomState extends State<OnboardingScreenCustom> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;

    return Column(

      children: [
        Image.asset('assets/images/onboarding_${widget.onboarding.image}.png'),
        SizedBox(height:height*0.03 ,),
        Text(widget.onboarding.title,style: AppStyles.bold20Primary,),
        SizedBox(height:height*0.03 ,),
        Text(widget.onboarding.content,style: Theme.of(context).textTheme.labelSmall,),
        SizedBox(height:height*0.03 ,),

      ],
    );
  }
}
