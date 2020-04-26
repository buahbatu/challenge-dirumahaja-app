import 'package:dirumahaja/core/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSholat extends StatelessWidget {
  final String locationName;
  final Map<String, dynamic> times;

  const InfoSholat(this.locationName, this.times, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 21),
      child: Material(
        elevation: 2,
        color: HexColor('504658'),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => launch('https://jadwal-imsakiyah.tirto.id/'),
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    ReCase(locationName).titleCase,
                    style: GoogleFonts.muli(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(height: 12),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Container(width: 12),
                      AppImages.masjidSvg.toSvgPicture(height: 72),
                      Container(width: 10),
                      Expanded(child: getTimeBar()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatNumber(int n) {
    final per10 = n / 10;
    if (per10 > 1) {
      return n.toString();
    } else {
      return '0' + n.toString();
    }
  }

  Widget getTimeBar() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            getTimeItem('Imsak',
                '${formatNumber(times['im']['h'])}:${formatNumber(times['im']['m'])}'),
            getTimeItem('Subuh',
                '${formatNumber(times['sb']['h'])}:${formatNumber(times['sb']['m'])}'),
            getTimeItem('Zhuhur',
                '${formatNumber(times['zh']['h'])}:${formatNumber(times['zh']['m'])}'),
          ],
        ),
        Container(height: 8),
        Row(
          children: <Widget>[
            getTimeItem('Ashar',
                '${formatNumber(times['as']['h'])}:${formatNumber(times['as']['m'])}'),
            getTimeItem('Magrib',
                '${formatNumber(times['mg']['h'])}:${formatNumber(times['mg']['m'])}'),
            getTimeItem('Isya',
                '${formatNumber(times['is']['h'])}:${formatNumber(times['is']['m'])}'),
          ],
        ),
      ],
    );
  }

  Expanded getTimeItem(String title, String time) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.raleway(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Text(
            time,
            style: GoogleFonts.muli(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
