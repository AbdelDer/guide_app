import 'package:flutter/material.dart';
import 'package:guide_app/lang/app_localizations.dart';
import 'package:guide_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void LocaleChangeCallback(Locale locale);

class LanguageScreen extends StatefulWidget {
  final LocaleChangeCallback onLocaleChange;

  LanguageScreen({Key key, this.onLocaleChange}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState(onLocaleChange);
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool _selected = false;
  SharedPreferences prefs;
  double _fontSize;
  final LocaleChangeCallback onLocaleChange;

  _LanguageScreenState(this.onLocaleChange);

  _loadHomeScreen() async {
    prefs = await SharedPreferences.getInstance();
    String lang = (prefs.getString('lang') ?? '');
//    prefs.setString("lang", "");
    if (lang == '') {
      return false;
    } else {
      widget.onLocaleChange(Locale(lang));
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _loadHomeScreen(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return HomeScreen(onLocaleChange: onLocaleChange,);
          } else {
            return Stack(
              children: [
                HomeScreen(onLocaleChange: onLocaleChange,),
                Center(
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.shortestSide < 600 ? 280 : 300,
                    width: MediaQuery.of(context).size.shortestSide < 600 ? 280 : 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'choisir une langue',
                              style: TextStyle(color: Colors.white, fontSize: _fontSize,),
                            ),
                            Text(
                              'إختر اللغة',
                              style: TextStyle(color: Colors.white, fontSize: _fontSize,),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            RadioListTile(
                              title: Text(
                                'Français',
                                style: TextStyle(color: Colors.white, fontSize: _fontSize,),
                              ),
                              activeColor: Colors.green,
                              value: true,
                              onChanged: (bool value) {
                                setState(() {
                                  _selected = !_selected;
                                  String lang = _selected ? "ar" : "fr";
                                  widget.onLocaleChange(Locale(lang));
//                                  await prefs.setString("lang", lang);
                                });
                              },
                              groupValue: !_selected,
                            ),
                            RadioListTile(
                              title: Text(
                                'العربية',
                                style: TextStyle(color: Colors.white, fontSize: _fontSize,),
                              ),
                              activeColor: Colors.green,
                              value: false,
                              onChanged: (bool value) {
                                setState(() {
                                  _selected = !_selected;
                                  String lang = _selected ? "ar" : "fr";
                                  widget.onLocaleChange(Locale(lang));
//                                  await prefs.setString("lang", lang);
                                });
                              },
                              groupValue: !_selected,
                            ),
                          ],
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(AppLocalizations.of(context).translate('ok'),
                            style: TextStyle(fontSize: _fontSize),),
                          onPressed: () async{
                            String lang = _selected ? "ar" : "fr";
                            widget.onLocaleChange(Locale(lang));
                            await prefs.setString("lang", lang);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }

  @override
  void didUpdateWidget(LanguageScreen oldWidget) {
    _fontSize = MediaQuery.of(context).size.shortestSide < 600 ? 20 : 26;
  }
}
