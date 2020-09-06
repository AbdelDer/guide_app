import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'language_screen.dart';

class SplashScreen extends StatefulWidget {

  final LocaleChangeCallback onLocaleChange;

  SplashScreen({Key key, this.onLocaleChange}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _navigateToHome() {
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/language', (Route<dynamic> route) => false);
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 10500), () async{});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/intro.gif',
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
            _navigateToHome();
    });
  }
}
