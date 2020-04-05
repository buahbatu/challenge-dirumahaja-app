import 'package:dirumahaja/core/res/app_color.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createBody(),
    );
  }

  Stack createBody() {
    return Stack(
      children: <Widget>[
        getBackButton(),
      ],
    );
  }

  Widget getBackButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 32),
        RaisedButton(
          onPressed: onBackClick,
          color: Colors.white,
          shape: CircleBorder(),
          child: Icon(
            Icons.arrow_back,
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
      ],
    );
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
