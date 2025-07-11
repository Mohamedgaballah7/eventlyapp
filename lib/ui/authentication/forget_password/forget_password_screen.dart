import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});
   TextEditingController emailEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark,
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.forgot_password,style: Theme.of(context).textTheme.labelSmall,),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppAssets.forgetPassword),
              CustomTextFormField(
                controller: emailEditingController,
                hintName: AppLocalizations.of(context)!.email,prefixIcon: Image.asset(AppAssets.iconEmail,color: Theme.of(context).primaryColorLight,),),
              CustomElavatedButton(onPressed: (){}, textName: AppLocalizations.of(context)!.reset_password)
            ],
          ),
        ),
      ),
    );
  }
}
