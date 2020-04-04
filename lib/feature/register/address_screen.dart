import 'package:dirumahaja/core/location/location.dart';
import 'package:dirumahaja/core/location/map_data.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/tools/static_map.dart';
import 'package:dirumahaja/feature/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();

    getCoordinates();
  }

  Position position;

  void getCoordinates() async {
    final readPosition = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      position = readPosition;
    });
  }

  void goToMapScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MapScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 52),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 64),
            getTitle(),
            getFormBox(),
            Container(height: 64),
          ],
        ),
      ),
    );
  }

  Widget getTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Rumah mu dimana?',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 8),
          Text(
            'Biar kami bisa ingetin kalo kamu keluar rumah',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFormBox() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Koordinat Rumah',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColor.titleColor.toHexColor(),
              ),
            ),
            Container(height: 8),
            InkWell(
              onTap: () => goToMapScreen(),
              child: TextField(
                style: GoogleFonts.muli(),
                decoration: InputDecoration(
                  enabled: false,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  hintText: position == null
                      ? '247.00032, 12.00023'
                      : '${position.latitude}, ${position.longitude}',
                  filled: true,
                  fillColor: AppColor.greyBgColor.toHexColor(),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8),
                    ),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 16),
            ...getMapSections(),
          ],
        ),
      ),
    );
  }

  List<Widget> getMapSections() {
    return [
      Text(
        'Cakupan Lingkungan Rumah',
        style: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: AppColor.titleColor.toHexColor(),
        ),
      ),
      Container(height: 8),
      InkWell(child: getMapRect(), onTap: goToMapScreen),
      Container(height: 8),
      // Text(
      //   'Lingkungan rumah 500m dari titik rumah',
      //   style: GoogleFonts.muli(
      //     fontSize: 12,
      //     color: AppColor.bodyColor.toHexColor(),
      //   ),
      // ),
    ];
  }

  Stack getMapRect() {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (position == null)
          Center(
            child: Container(
              height: 200,
              color: AppColor.greyBgColor.toHexColor(),
            ),
          ),
        if (position != null)
          StaticMap(MapData(
            Coordinate(position.latitude, position.longitude),
            width.toInt(),
            200,
          )),
        Container(
          height: 140,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.blue.withOpacity(0.4)),
        ),
        Container(
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
      ],
    );
  }

  Container getGenderRow() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColor.greyBgColor.toHexColor(),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              elevation: 0,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Pria',
                style: GoogleFonts.muli(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              color: HexColor('0165C0'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: MaterialButton(
              elevation: 0,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Wanita',
                style: GoogleFonts.muli(
                  color: AppColor.bodyColor.toHexColor(),
                  // color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              // color: HexColor('0165C0'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
