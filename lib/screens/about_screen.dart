import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guide_app/lang/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Future<void> _launched;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
//      height: double.infinity,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppLocalizations.of(context).translate('about'),
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
//          SizedBox(height: 20.0),
          Container(
            width: 500,
//                  height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: 280.0,
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width / 3,
                      image: AssetImage('assets/images/black_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                ),
                Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: MediaQuery.of(context).size.height / 3,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(10.0),
//                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Text(
                          'TOP ART TIMA',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 22 : 28,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          AppLocalizations.of(context)
                              .translate('tatdescription'),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 12 : 26,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          AppLocalizations.of(context).translate('tatmore'),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 24,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          AppLocalizations.of(context).translate('adress'),
                          style: TextStyle(
                              color: Colors.white54,
                              // fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22,),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.shortestSide < 600 ? 24 : 30,
                              ),
                              onPressed: () => setState(() {
                                if (Theme.of(context).platform ==
                                    TargetPlatform.android) {
                                  _launched = _launchInBrowser(
                                      "fb://page/109070614224996");
                                } else {
                                  _launched = _launchInBrowser(
                                      "fb://page?id=109070614224996");
                                }
                              }),
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.shortestSide < 600 ? 24 : 30,
                              ),
                              onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    "https://www.instagram.com/toparttima");
                              }),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.message,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.shortestSide < 600 ? 24 : 30,
                              ),
                              onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    "mailto://top.art.tima@gmail.com");
                              }),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.shortestSide < 600 ? 24 : 30,
                              ),
                              onPressed: () => setState(() {
                                _launched =
                                    _launchInBrowser("tel:+212666898767");
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
