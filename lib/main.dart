
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapproute/providers/app_languages_provider.dart';
import 'package:eventlyapproute/providers/app_theme_provider.dart';
import 'package:eventlyapproute/providers/event_list_provider.dart';
import 'package:eventlyapproute/providers/user_provider.dart';
import 'package:eventlyapproute/ui/authentication/forget_password/forget_password_screen.dart';
import 'package:eventlyapproute/ui/authentication/login/login_screen.dart';
import 'package:eventlyapproute/ui/authentication/register/register_screen.dart';
import 'package:eventlyapproute/ui/boarding/introduction_screen.dart';
import 'package:eventlyapproute/ui/edit_event/edit_event.dart';
import 'package:eventlyapproute/ui/home/add_event/add_event.dart';
import 'package:eventlyapproute/utils/app_routes.dart';
import 'package:eventlyapproute/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'ui/home/homescreen.dart';
import 'ui/boarding/onboardingscreen.dart';
import 'l10n/app_localizations.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppLanguagesProvider() ),
      ChangeNotifierProvider(create: (context) => AppThemeProvider() ),
      ChangeNotifierProvider(create: (context) => EventListProvider() ),
      ChangeNotifierProvider(create: (context) => UserProvider() ),
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguagesProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.introductionRouteName,
      routes: {
        AppRoutes.introductionRouteName:(context)=>IntroductionScreen(),
        AppRoutes.loginRouteName:(context)=>LoginScreen(),
        AppRoutes.registerRouteName:(context)=>RegisterScreen(),
        AppRoutes.forgetRouteName:(context)=>ForgetPasswordScreen(),
        AppRoutes.onboardingRouteName:(context)=>Onboardingscreen(),
        AppRoutes.homeRouteName:(context)=>Homescreen(),
        AppRoutes.addEventRouteName:(context)=>AddEventScreen(),
        AppRoutes.editEventRouteName:(context)=>EditEvent(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

}
