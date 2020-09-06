import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide_app/lang/app_localizations.dart';
import 'package:guide_app/screens/language_screen.dart';
import 'package:guide_app/screens/partner_screen.dart';
import 'package:guide_app/screens/service_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_screen.dart';

class HomeScreen extends StatefulWidget {

  final LocaleChangeCallback onLocaleChange;

  HomeScreen({Key key, this.onLocaleChange}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab;
  Widget bodyWidget = ServiceScreen();
  SharedPreferences prefs;
  double _fontSize;

  _HomeScreenState() {
    _currentTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/bg.jpg',
              fit: BoxFit.fill,
            ),
            bodyWidget,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab,
        onTap: (int value) async{
          if(value == 3) {
            prefs = await SharedPreferences.getInstance();
            if((prefs.getString('lang') ?? '') == 'fr') {
              await prefs.setString("lang", 'ar');
              widget.onLocaleChange(Locale('ar'));
            } else {
              await prefs.setString("lang", 'fr');
              widget.onLocaleChange(Locale('fr'));
            }
          }
          setState(() {
            if(value != 3) {
              _currentTab = value;
            }
            if (value == 0) {
              bodyWidget = ServiceScreen();
            } else if (value == 1) {
              bodyWidget = PartnerScreen();
            } else if(value == 2){
              bodyWidget = AboutScreen();
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.handHoldingHeart,
              size: 20.0,
            ),
//            title: SizedBox.shrink(),
            title: Text(
              AppLocalizations.of(context).translate('services'),
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.handshake,
              size: 20.0,
            ),
//            title: SizedBox.shrink(),
            title: Text(
              AppLocalizations.of(context).translate('partners'),
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
//              backgroundImage: NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
              backgroundImage: AssetImage('assets/images/black_logo.jpg'),
            ),
//            title: SizedBox.shrink(),
            title: Text(
              AppLocalizations.of(context).translate('about'),
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.translate,
              size: 20.0,
            ),
//            title: SizedBox.shrink(),
            title: Text(
              AppLocalizations.of(context).translate('language'),
              style: TextStyle(fontSize: _fontSize),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    _fontSize = MediaQuery.of(context).size.shortestSide < 600 ? 16 : 20;
  }
}
