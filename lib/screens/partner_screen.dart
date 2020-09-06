import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guide_app/lang/app_localizations.dart';
import 'package:guide_app/models/partner_model.dart';

import 'detail_screen.dart';

class PartnerScreen extends StatefulWidget {
  @override
  _PartnerScreenState createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  List<Widget> widgetsOnTop;
  int widgetOnTopIndex;
  int _selectedIndex;
  String _search = "";
  double _fontSize;

  List _tagsName = [
    "Hotels",
    "Restaurants",
    "Cafes",
    "Sante",
    "Loisirs",
    "Construction",
    "Spa-hammam",
    "Coiffure",
    "Ecoles",
    "Salle des fetes",
    "Immobilier",
    "Deco",
    "Electromenager",
    "Agence",
    "Patisserie - boulangerie",
    "Bijouterie",
    "Parapharmacie",
    "Vetements"
  ];

//  List<IconData> _icons;
//   List<RaisedButton> _tags;
  var searchIcon;
  Stream<List<Partner>> myStream;

  _PartnerScreenState() {
    _selectedIndex = -1;

    searchIcon = Icon(
      FontAwesomeIcons.search,
      color: Colors.red,
    );
  }

  @override
  void initState() {
    myStream = getAllPartners("");
  }

  @override
  void didChangeDependencies() {

    _fontSize = MediaQuery.of(context).size.shortestSide < 600 ? 18 : 30;

    widgetsOnTop = [
      Text(
        AppLocalizations.of(context).translate('ourpartners'),
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 30 : 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Expanded(
//        width: 330,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _search = value;
              if (_selectedIndex == -1) {
                myStream = getAllPartners("");
              } else {
                myStream = getAllPartners(_tagsName[_selectedIndex]);
              }
            });
          },
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
//            errorStyle: TextStyle(
//              color: Colors.red,
//              fontSize: 16,
//              fontWeight: FontWeight.bold,
//            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: _fontSize,
            ),
            hintText: AppLocalizations.of(context).translate('searchhint'),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
//        padding: EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetsOnTop
                    .elementAt(widgetOnTopIndex == null ? 0 : widgetOnTopIndex),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widgetOnTopIndex == null || widgetOnTopIndex == 0) {
                        widgetOnTopIndex = 1;
                        searchIcon = Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.red,
                        );
                      } else {
                        widgetOnTopIndex = 0;
                        _search = "";
                        if (_selectedIndex == -1) {
                          myStream = getAllPartners("");
                        } else {
                          myStream = getAllPartners(_tagsName[_selectedIndex]);
                        }
                        searchIcon = Icon(
                          FontAwesomeIcons.search,
                          color: Colors.red,
                        );
                      }
                    });
                  },
                  child: searchIcon,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: _tags.toList(),
              children: [
                RaisedButton(
                  onPressed: () => _filter(0),
                  child: Text(
                    AppLocalizations.of(context).translate('hotels'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 0 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(1),
                  child: Text(
                    AppLocalizations.of(context).translate('restaurants'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 1 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(2),
                  child: Text(
                    AppLocalizations.of(context).translate('cafes'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 2 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(3),
                  child: Text(
                    AppLocalizations.of(context).translate('health'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 3 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(4),
                  child: Text(
                    AppLocalizations.of(context).translate('hobbies'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 4 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(5),
                  child: Text(
                    AppLocalizations.of(context).translate('construction'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 5 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(6),
                  child: Text(
                    AppLocalizations.of(context).translate('spahammam'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 6 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(7),
                  child: Text(
                    AppLocalizations.of(context).translate('hairdressing'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 7 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(8),
                  child: Text(
                    AppLocalizations.of(context).translate('schools'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 8 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(9),
                  child: Text(
                    AppLocalizations.of(context).translate('partyroom'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 9 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(10),
                  child: Text(
                    AppLocalizations.of(context).translate('realestate'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 10 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(11),
                  child: Text(
                    AppLocalizations.of(context).translate('deco'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 11 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(12),
                  child: Text(
                    AppLocalizations.of(context).translate('homeappliance'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 12 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(13),
                  child: Text(
                    AppLocalizations.of(context).translate('agencies'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 13 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(14),
                  child: Text(
                    AppLocalizations.of(context).translate('bakery'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 14 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(15),
                  child: Text(
                    AppLocalizations.of(context).translate('jewelry'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 15 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(16),
                  child: Text(
                    AppLocalizations.of(context).translate('drugstore'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 16 ? Colors.red : Color(0xFFB4C1C4),
                ),
                RaisedButton(
                  onPressed: () => _filter(17),
                  child: Text(
                    AppLocalizations.of(context).translate('clothes'),
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 14 : 22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  elevation: 5.0,
                  color: _selectedIndex == 17 ? Colors.red : Color(0xFFB4C1C4),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          StreamBuilder(
            stream: myStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: GestureDetector(
                                    child: Container(
                                      child: Hero(
                                        tag: snapshot.data[index].name +
                                            "$index",
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/partners/" +
                                                  snapshot.data[index].image),
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (context, child, progress) {
                                            return progress == null
                                                ? child
                                                : LinearProgressIndicator();
                                          },
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return DetailScreen(
                                            snapshot.data[index].name +
                                                "$index",
                                            "assets/images/partners/" +
                                                snapshot.data[index].image);
                                      }));
                                    },
                                  ),
                                ),
                                Positioned(
                                  width: MediaQuery.of(context).size.width,
                                  bottom: 22.0,
                                  child: Container(
//                                    height: 120.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
//                                      borderRadius:
//                                      BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                            fontSize: _fontSize,
                                            fontWeight: FontWeight.w600,
//                                            letterSpacing: 1.2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.none) {}
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  _filter(index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = -1;
        myStream = getAllPartners("");
      } else {
        _selectedIndex = index;
        myStream = getAllPartners(_tagsName[index]);
      }
    });
  }

  Stream<List<Partner>> getAllPartners(String type) async* {
    List partners = [];
    if (_search == "" || _search == null) {
      if (type == "") {
        partners = await Partner.getAllPartners();
      } else {
        partners = await Partner.getAllPartnersByType(type);
      }
    } else {
      partners = await Partner.getAllPartnersByParam(
          type, _search.replaceAll(new RegExp('\''), '\'\''));
    }
    yield partners;
  }
}
