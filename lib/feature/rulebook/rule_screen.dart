import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/rulebook/rule_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class RuleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColor.skyGradient),
        child: Stack(
          children: <Widget>[
            ...getBackgrounds(),
            getBackButton(context),
            getContent(),
          ],
        ),
      ),
    );
  }

  Widget getBackButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 32),
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
          shape: CircleBorder(),
          child: AppImages.arrowLeftSvg.toSvgPicture(),
        ),
      ],
    );
  }

  Container getContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: <Widget>[
          Container(height: 90),
          Text(
            'Aturan Main',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 8),
          Text(
            'Baca dulu biar paham, malu bertanya sesat di jalan',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
          Container(height: 32),
          RuleBox(height: 450),
        ],
      ),
    );
  }

  Column getPageTitle() {
    return Column(
      children: <Widget>[
        Container(height: 48),
        Text(
          'AYOK #DIRUMAHAJA',
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
      ],
    );
  }

  List<Widget> getBackgrounds() {
    return [
      AppImages.homeBgMediumPng.toPngImage(
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
      AppImages.cloudBgPng.toPngImage(
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    ];
  }

  Widget getHelpButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 32),
        RaisedButton(
          onPressed: () {},
          color: Colors.white,
          shape: CircleBorder(),
          child: AppImages.helpSvg.toSvgPicture(),
        ),
      ],
    );
  }

  Widget getNotifButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(height: 32),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              color: Colors.white,
              shape: CircleBorder(),
              child: AppImages.helpSvg.toSvgPicture(),
            ),
            Container(
              height: 12,
              width: 12,
              margin: const EdgeInsets.only(left: 26, bottom: 26),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor('FF5555'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
