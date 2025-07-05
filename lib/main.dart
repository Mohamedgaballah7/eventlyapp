
import 'package:eventlyapproute/providers/app_languages_provider.dart';
import 'package:eventlyapproute/providers/app_theme_provider.dart';
import 'package:eventlyapproute/utils/app_routes.dart';
import 'package:eventlyapproute/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/home/homescreen.dart';
import 'ui/boarding/onboardingscreen.dart';
import 'l10n/app_localizations.dart';
void main()
{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppLanguagesProvider() ),
      ChangeNotifierProvider(create: (context) => AppThemeProvider() ),
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
      initialRoute: AppRoutes.onboardingRouteName,
      routes: {
        AppRoutes.onboardingRouteName:(context)=>Onboardingscreen(),
        AppRoutes.homeRouteName:(context)=>Homescreen(),
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
