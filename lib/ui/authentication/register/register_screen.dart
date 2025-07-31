import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:eventlyapproute/utils/dialog_message.dart';
import 'package:eventlyapproute/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_routes.dart';
import '../../widgets/switch_toogle_language.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameEditingController = TextEditingController(text: 'mohamedgaballah');

  TextEditingController emailEditingController = TextEditingController(text: 'modys1106@gmaiil.com');

  TextEditingController passwordEditingController = TextEditingController(text: '425579');

  TextEditingController rePasswordEditingController = TextEditingController(text: '425579');

  final formKey = GlobalKey<FormState>();
  bool obscureTextPassword = true;
  bool obscureTextRePassword = true;
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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme
              .of(context)
              .primaryColorDark,
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.register, style: Theme
            .of(context)
            .textTheme
            .labelSmall,),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.01, horizontal: width * 0.03),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Image.asset(AppAssets.EventlySplashLogo, height: height * 0.2,
                  width: width * 0.3,),
                Form(
                    key: formKey,
                    child: Column(
                  children: [
                    CustomTextFormField(
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_email;
                        }
                        return null;
                      },
                      controller: nameEditingController,
                      hintName: AppLocalizations.of(context)!.name,
                      prefixIcon: Image.asset(AppAssets.profileIcon,color: Theme.of(context).primaryColorLight,),
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController,
                      hintName: AppLocalizations.of(context)!.email,
                      prefixIcon: Image.asset(AppAssets.iconEmail,color: Theme.of(context).primaryColorLight,),
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_email;
                        }
                        final bool emailValid =
                        RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text.trim());
                        if (!emailValid) {
                          return AppLocalizations.of(context)!
                              .please_valid_email;
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: passwordEditingController,
                      hintName: AppLocalizations.of(context)!.password,
                      prefixIcon: Image.asset(AppAssets.iconPassword,color: Theme.of(context).primaryColorLight,),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureTextPassword = !obscureTextPassword;
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.remove_red_eye_rounded,
                          color: Theme.of(context).primaryColorLight,),),
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_valid_password;
                        }
                        if (text
                            .trim()
                            .length < 6) {
                          return AppLocalizations.of(context)!
                              .please_enter_password;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: obscureTextPassword,
                      obscuringCharacter: '*',
                    ),
                    CustomTextFormField(
                      controller: rePasswordEditingController,
                      hintName: AppLocalizations.of(context)!.re_password,
                      prefixIcon: Image.asset(AppAssets.iconPassword,color: Theme.of(context).primaryColorLight,),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureTextRePassword = !obscureTextRePassword;
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.remove_red_eye_rounded,
                          color: Theme.of(context).primaryColorLight,),),
                      keyboardType: TextInputType.number,
                      obscureText: obscureTextRePassword,
                      obscuringCharacter: '*',
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_valid_password;
                        }
                        if (text
                            .trim()
                            .length < 6) {
                          return AppLocalizations.of(context)!
                              .please_enter_password;
                        }
                        if (text != passwordEditingController.text) {
                          return AppLocalizations.of(context)!
                              .please_valid_password;
                        }
                        return null;
                      },
                    ),
                    CustomElavatedButton(
                        onPressed: () {
                          createAccountCheck();
                        },
                        textName: AppLocalizations.of(context)!.create_account),
                  ],
                )),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.already_have_account,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelSmall,),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                      child: Text(AppLocalizations.of(context)!.login,
                          style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          )),
                    )
                  ],
                ),
                SwitchToogleLanguage()
              ],
            ),
          ),
        ),
      ),
    );
  }
  void createAccountCheck()async{
    if (formKey.currentState!.validate() == true) {
      DialogMessage.showLoadingMessage(context: context, text: AppLocalizations.of(context)!.loading);
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        );
        MyUser user=MyUser(
            id: credential.user?.uid??'',
            name: nameEditingController.text,
            email: emailEditingController.text
        );
        FirebaseUtils.addUserToFireStore(user);
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.changeUser(user);
        var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
        eventListProvider.changeToSelectedIndex(0, userProvider.currentUser!.id);
        DialogMessage.hideLoadingMessage(context: context);
        DialogMessage.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.successfully,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: (){
            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homeRouteName,(route) => false,);
          }
        );
      }
      // on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
      // }
      catch (e) {
        DialogMessage.hideLoadingMessage(context: context);
        DialogMessage.showMessage(context: context,
          title: AppLocalizations.of(context)!.connection_failed,
            message: e.toString(),
          posActionName: AppLocalizations.of(context)!.ok,
        );
      }

    }
  }
}
