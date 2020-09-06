import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  String _tag = "";
  String _imagePath = "";

  DetailScreen(this._tag, this._imagePath);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
          child: Center(
            child: Hero(
              tag: _tag,
              child: Image(
              image: AssetImage(
                _imagePath,
              ),
            ),
          ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
    );
  }
}