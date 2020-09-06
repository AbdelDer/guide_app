import 'package:flutter/material.dart';
import 'package:guide_app/lang/app_localizations.dart';

class ServiceCarousel extends StatefulWidget {
  @override
  _ServiceCarouselState createState() => _ServiceCarouselState();
}

class _ServiceCarouselState extends State<ServiceCarousel> {
  double _fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.symmetric(horizontal: 20.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                'Hôtels Exclusifs',
//                style: TextStyle(
//                  fontSize: 22.0,
//                  fontWeight: FontWeight.bold,
//                  letterSpacing: 1.5,
//                ),
//              ),
////              GestureDetector(
////                onTap: () => print('Voir tout'),
////                child: Text(
////                  'Voir tout',
////                  style: TextStyle(
////                    color: Theme.of(context).primaryColor,
////                    fontSize: 16.0,
////                    fontWeight: FontWeight.w600,
////                    letterSpacing: 1.0,
////                  ),
////                ),
////              ),
//            ],
//          ),
//        ),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 13,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          bottom: 10.0,
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).translate('service${index + 1}'),
                                  style: TextStyle(
                                    fontSize: _fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              height: 250.0,
                              width: MediaQuery.of(context).size.width,
                              image: AssetImage('assets/images/services/${index + 1}.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    _fontSize = MediaQuery.of(context).size.shortestSide < 600 ? 18 : 24;
  }
}
