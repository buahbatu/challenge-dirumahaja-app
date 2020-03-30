import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/activity/activity_screen.dart';
import 'package:dirumahaja/feature/friend/friend_screen.dart';
import 'package:dirumahaja/feature/friend/share_screen.dart';
import 'package:dirumahaja/feature/information/information_screen.dart';
import 'package:dirumahaja/feature/notification/notification_screen.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:dirumahaja/feature/status/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    checkTimeBackground();
  }

  Gradient skyGradient = AppColor.skyGradient;
  Gradient shadeGradient = AppColor.shadeNoonGradient;
  Color userNameColor = Colors.black;

  void checkTimeBackground() {
    setState(() {
      final hour = DateTime.now().hour;
      if (hour >= 6 && hour < 14) {
        skyGradient = AppColor.skyGradient;
      } else if (hour >= 14 && hour < 19) {
        skyGradient = AppColor.skyNoonGradient;
        shadeGradient = AppColor.shadeNoonGradient;
      } else {
        skyGradient = AppColor.skyNightGradient;
        shadeGradient = AppColor.shadeNightGradient;
        userNameColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: skyGradient),
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
        getUserPin(),
        Expanded(child: Container()),
        getMainMenu(),
        Container(height: 10),
        getPrixaButton(),
        Container(height: 16),
      ],
    );
  }

  FlatButton getPrixaButton() {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white),
      ),
      child: Text(
        'Periksa Gejala with Prixa.ai',
        style: GoogleFonts.muli(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        launch('https://prixa.ai/corona');
      },
    );
  }

  Widget getMainMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ActivityScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      AppImages.productivePng.toPngImage(),
                      Container(height: 16),
                      Text(
                        'Mari Produktif',
                        style: GoogleFonts.muli(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.titleColor.toHexColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(width: 8),
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => InformationScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      AppImages.assestmentSvg.toSvgPicture(),
                      Container(height: 16),
                      Text(
                        'Update Corona',
                        style: GoogleFonts.muli(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.titleColor.toHexColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getUserPin() {
    return Column(
      children: <Widget>[
        Container(height: 32),
        Text(
          'RaviDewaBucin',
          style: GoogleFonts.muli(color: userNameColor),
        ),
        Container(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor('8EC13F'),
              ),
            ),
            Container(width: 4),
            Text(
              'Bandung',
              style: GoogleFonts.raleway(
                color: userNameColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(height: 8),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AppImages.pinSvg.toSvgPicture(width: 52),
            Column(
              children: <Widget>[
                AppImages.heroPng.toPngImage(width: 42),
                Container(height: 16),
              ],
            ),
          ],
        ),
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
            'Teman Challenge',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
          Container(height: 4),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => FriendScreen()),
              );
            },
            child: Row(
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
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ShareScreen(
                  'RaviDewaBucin',
                  AppImages.heroPng,
                ),
              ));
            },
          )
        ],
      ),
    );
  }

  Widget createImage(String path) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: HexColor('8EC13F'), width: 2),
          ),
        ),
        path.toPngImage(width: 24),
      ],
    );
  }

  Widget getDayCount() {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => StatusScreen(),
          ));
        },
        child: Container(
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
        ),
      ),
    );
  }

  Text getPageTitle() {
    return Text(
      'AYOK #DIRUMAHAJA',
      style: GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: userNameColor == Colors.white
            ? userNameColor
            : AppColor.titleColor.toHexColor(),
      ),
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
      if (skyGradient == AppColor.skyNoonGradient)
        AppImages.noonShadeSvg.toSvgPicture(
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      if (skyGradient == AppColor.skyNightGradient)
        AppImages.nightShadeSvg.toSvgPicture(
          width: double.infinity,
          fit: BoxFit.fill,
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NotificationScreen(),
            ));
          },
          color: Colors.white,
          shape: CircleBorder(),
          child: AppImages.bellSvg.toSvgPicture(),
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
