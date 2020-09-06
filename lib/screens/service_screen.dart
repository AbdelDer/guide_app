import 'package:flutter/material.dart';
import 'package:guide_app/lang/app_localizations.dart';
import 'package:guide_app/widgets/service_carousel.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppLocalizations.of(context).translate('ourservices'),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.shortestSide < 600 ? 30 : 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
//          SizedBox(height: 20.0),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: _icons
//                .asMap()
//                .entries
//                .map(
//                  (MapEntry map) => _buildIcon(map.key),
//            )
//                .toList(),
//          ),
//          SizedBox(height: 20.0),
//          DestinationCarousel(),
          SizedBox(height: 20.0),
          ServiceCarousel(),
        ],
      ),
    );
  }
}
