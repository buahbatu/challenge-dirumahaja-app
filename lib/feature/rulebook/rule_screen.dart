import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/rulebook/credit_box.dart';
import 'package:dirumahaja/feature/rulebook/rule_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
            getContent(),
            getBackButton(context),
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
          child: Icon(
            Icons.arrow_back,
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
      ],
    );
  }

  Widget getContent() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: <Widget>[
            Container(height: 80),
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
            RuleBox(),
            Container(height: 32),
            CreditBox(),
            Container(height: 32),
            getAboutUsSection(),
            Container(height: 32),
          ],
        ),
      ),
    );
  }

  Widget getAboutUsSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          launch(
            'https://www.notion.so/buahbatu/875535cf90df421e93b51260cbb3af7f?v=b05f8329f6f54b4fab8abca9d9c8766c',
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text(
                'About Us',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColor.titleColor.toHexColor(),
                ),
              ),
            ],
          ),
        ),
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
      Align(
        alignment: Alignment.bottomCenter,
        child: AppImages.homeBgMediumPng.toPngImage(
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: AppImages.cloudBgPng.toPngImage(
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    ];
  }
}
