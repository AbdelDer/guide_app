import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guide_app/screens/about_screen.dart';
import 'package:guide_app/screens/home_screen.dart';
import 'package:guide_app/screens/language_screen.dart';
import 'package:guide_app/screens/partner_screen.dart';
import 'package:guide_app/screens/service_screen.dart';
import 'package:guide_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lang/app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AppLocalizations appLocalizations = AppLocalizations(Locale('fr'));

  onLocaleChange(Locale l) {
    setState(() {
      appLocalizations.locale = l;
      appLocalizations.delegate.load(l);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      locale: appLocalizations?.locale ?? Locale('fr'),

      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),

      home: SplashScreen(),

      // List all of the app's supported locales here
      supportedLocales: [
        Locale('fr'),
        Locale('ar'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        appLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },

      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/language': (context) => LanguageScreen(onLocaleChange: onLocaleChange),
        '/home': (context) => HomeScreen(onLocaleChange: onLocaleChange,),
        '/service': (context) => ServiceScreen(),
        '/partner': (context) => PartnerScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
