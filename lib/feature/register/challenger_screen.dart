import 'package:dirumahaja/core/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengerScreen extends StatelessWidget {
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
            'Siapa yang nantang kamu?',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 8),
          Text(
            'Kasih tau dia kalo kamu juga bisa',
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
              'Username penantang',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColor.titleColor.toHexColor(),
              ),
            ),
            Container(height: 8),
            TextField(
              style: GoogleFonts.muli(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                hintText: 'Isi username teman mu...',
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
            Container(height: 8),
            Text(
              'Kosongkan jika tidak ada',
              style: GoogleFonts.muli(
                fontSize: 12,
                color: AppColor.bodyColor.toHexColor(),
              ),
            ),
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
      Container(
        height: 130,
        color: AppColor.greyBgColor.toHexColor(),
      ),
      Container(height: 8),
      Text(
        'Lingkungan rumah 500m dari titik rumah',
        style: GoogleFonts.muli(
          fontSize: 12,
          color: AppColor.bodyColor.toHexColor(),
        ),
      ),
    ];
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
