import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/providers/event_list_provider.dart';
import 'package:eventlyapproute/providers/user_provider.dart';
import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/ui/widgets/switch_toogle_language.dart';
import 'package:eventlyapproute/utils/app_assets.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_routes.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:eventlyapproute/utils/dialog_message.dart';
import 'package:eventlyapproute/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController=TextEditingController(text:'modys1106@gmaiil.com');
  TextEditingController passwordEditingController=TextEditingController(text:'425579');
  final formKey=GlobalKey<FormState>();
  bool obscureText=true;
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAssets.EventlySplashLogo,height: height*0.2,width: width*0.3,),
                Form(
                  key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          validator: (text){
                            if(text==null||text.trim().isEmpty){
                              return AppLocalizations.of(context)!.please_enter_email;
                            }
                            final bool emailValid =
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text.trim());
                            if(!emailValid){
                              return AppLocalizations.of(context)!.please_valid_email;
                            }
                            return null;
                          },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailEditingController,
                            prefixIcon: Image.asset(AppAssets.iconEmail,color: Theme.of(context).primaryColorLight,),
                            hintName: AppLocalizations.of(context)!.email),
                        CustomTextFormField(
                            validator: (text){
                              if(text==null||text.trim().isEmpty){
                                return AppLocalizations.of(context)!.please_valid_password;
                              }
                              if(text.trim().length<6){
                                return AppLocalizations.of(context)!.please_enter_password;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            obscureText: obscureText,
                            obscuringCharacter: '*',
                            controller: passwordEditingController,
                            prefixIcon: Image.asset(AppAssets.iconPassword,color: Theme.of(context).primaryColorLight,),
                            suffixIcon: IconButton(
                               onPressed: () {
                                 obscureText = !obscureText;
                                 setState(() {

                                 });
                               },
                              icon: Icon(Icons.remove_red_eye_rounded,
                              color: Theme.of(context).primaryColorLight,),),
                            hintName: AppLocalizations.of(context)!.password),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pushNamed(AppRoutes.forgetRouteName);
                            },
                              child: Text(AppLocalizations.of(context)!.forget_password,
                                  style: AppStyles.bold16Primary.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryLight,
                                  )),
                            ),
                          ],
                        ),
                        CustomElavatedButton(
                            onPressed: (){
                              loginCheck();
                            },
                            textName: AppLocalizations.of(context)!.login),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.dont_have_account,style: Theme.of(context).textTheme.labelSmall,),
                            TextButton(onPressed: (){
                              Navigator.of(context).pushNamed(AppRoutes.registerRouteName);
                            },
                              child: Text(AppLocalizations.of(context)!.create_account,
                                  style: AppStyles.bold16Primary.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryLight,
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                indent: width*0.075,
                                endIndent: width*0.015,
                                color: AppColors.primaryLight,
                                thickness: 1.5,
                              ),
                            ),
                            Text(AppLocalizations.of(context)!.or,style: AppStyles.bold16Primary,),
                            Expanded(
                              child: Divider(
                                endIndent: width*0.075,
                                indent: width*0.015,
                                color: AppColors.primaryLight,
                                thickness: 1.5,
                              ),
                            ),
                          ],
                        ),
                        CustomElavatedButton(
                          onPressed: (){
                            signInWithGoogle();
                          },
                          textName: AppLocalizations.of(context)!.login_with_google,
                          textStyle: AppStyles.bold16Primary,
                          backgroundColor: AppColors.transparentColor,
                          isIcon: true,
                          iconName: Image.asset(AppAssets.iconGoogle),),
                        SwitchToogleLanguage()
                      ],
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> signInWithGoogle() async {
    DialogMessage.showLoadingMessage(
        context: context, text: AppLocalizations.of(context)!.loading);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return; // User canceled sign-in
      }

      // Get auth details
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            AppLocalizations.of(context)!.connection_failed,
            style: AppStyles.bold16White,)),
        );
        return;
      }

      // Read user from Firestore
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var userRead = await FirebaseUtils.readUserFromFireStore(user.uid);

      // If user doesn't exist in Firestore, add them
      if (userRead == null) {
        final newUser = MyUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await FirebaseUtils.addUserToFireStore(newUser);
        userProvider.changeUser(newUser);
      } else {
        userProvider.changeUser(userRead);
      }

      // Load user’s events
      var eventListProvider = Provider.of<EventListProvider>(
          context, listen: false);
      eventListProvider.changeToSelectedIndex(0, userProvider.currentUser!.id);
      DialogMessage.hideLoadingMessage(context: context);
      // Navigate to home screen
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    } catch (e) {
      DialogMessage.hideLoadingMessage(context: context);
      DialogMessage.showMessage(
        context: context,
        title: AppLocalizations.of(context)!.connection_failed,
        message: e.toString(),
        posActionName: AppLocalizations.of(context)!.ok,
      );
    }
  }


  void loginCheck()async{
    if(formKey.currentState!.validate()==true){
      DialogMessage.showLoadingMessage(context: context, text: AppLocalizations.of(context)!.loading);
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        );
        var user=await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user==null){
          return;
        }
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.changeUser(user);
        var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
        eventListProvider.changeToSelectedIndex(0, userProvider.currentUser!.id);
        eventListProvider.getAllFavouriteFromFireStore(userProvider.currentUser!.id);
        DialogMessage.hideLoadingMessage(context: context);
        DialogMessage.showMessage(context: context,
            message: AppLocalizations.of(context)!.successfully,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: (){
            Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
          }
        );
       }

      catch (e) {
        DialogMessage.hideLoadingMessage(context: context);
        DialogMessage.showMessage(
          context: context,
          title: AppLocalizations.of(context)!.connection_failed,
          message: e.toString(),
          posActionName: AppLocalizations.of(context)!.ok,
        );
      }

    }
  }
}
