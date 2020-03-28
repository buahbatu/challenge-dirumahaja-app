import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
          ],
        ),
      ),
    );
  }

  Column getContent() {
    return Column(
      children: <Widget>[
        Container(height: 32),
        getTopbar(),
        getStatusBoard(),
      ],
    );
  }

  Row getTopbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getHelpButton(),
        getPageTitle(),
        getNotifButton(),
      ],
    );
  }

  Widget getStatusBoard() {
    return Card(
      elevation: 2,
      color: HexColor('F0F6FB'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(23.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: getDayCount(),
          ),
          Flexible(
            flex: 7,
            child: getFriendCount(),
          ),
        ],
      ),
    );
  }

  Container getFriendCount() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Daftar Teman',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
          Container(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              createImage(AppImages.heroPng),
              createImage(AppImages.heroPng),
              createImage(AppImages.heroPng),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor('FFC010'),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+3',
                  style: GoogleFonts.muli(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 16),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '+ Ajak Teman',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.titleColor.toHexColor(),
                ),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Container createImage(String path) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path)),
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: HexColor('8EC13F'),
        ),
      ),
    );
  }

  Container getDayCount() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Lama kamu di rumah',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
          Container(height: 4),
          Text(
            '14 Hari',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 16),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColor.buttonColor.toHexColor(),
            ),
            child: Text(
              'Corona Hero',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Text getPageTitle() {
    return Text(
      'AYOK #DIRUMAHAJA',
      style: GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: AppColor.titleColor.toHexColor(),
      ),
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
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => RuleScreen()),
        );
      },
      color: Colors.white,
      shape: CircleBorder(),
      child: AppImages.helpSvg.toSvgPicture(),
    );
  }

  Widget getNotifButton() {
    return Stack(
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
    );
  }
}
