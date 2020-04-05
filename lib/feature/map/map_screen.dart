import 'dart:async';

import 'package:dirumahaja/core/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dirumahaja/core/res/app_color.dart';

class MapScreen extends StatefulWidget {
  final Position initPosition;
  const MapScreen(
    this.initPosition, {
    Key key,
  }) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createBody(),
    );
  }

  CameraPosition mapCenter;
  void cameraMoved(CameraPosition movedPosition) async {
    mapCenter = movedPosition;
  }

  Stack createBody() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initPosition.latitude,
              widget.initPosition.longitude,
            ),
            zoom: 15,
          ),
          myLocationEnabled: true,
          onCameraMove: cameraMoved,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        getBackButton(),
        Align(
          alignment: Alignment.center,
          child: getUserPin(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: getSelectButton(),
        ),
      ],
    );
  }

  Widget getSelectButton() {
    return Container(
      margin: EdgeInsets.all(16),
      child: RaisedButton(
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'Pilih Lokasi',
          style: GoogleFonts.muli(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        textColor: Colors.white,
        color: AppColor.buttonColor.toHexColor(),
        onPressed: () => Navigator.of(context).pop(mapCenter.target),
      ),
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

  Widget getUserPin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppImages.pinSvg.toSvgPicture(width: 24),
        Container(height: 28),
      ],
    );
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
