import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/entity/entity_notif.dart';
import 'package:dirumahaja/core/entity/entity_profile.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/activity/activity_screen.dart';
import 'package:dirumahaja/feature/status/status_board.dart';
import 'package:dirumahaja/feature/information/information_screen.dart';
import 'package:dirumahaja/feature/notification/notification_screen.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Gradient skyGradient = AppColor.skyGradient;
  Gradient shadeGradient = AppColor.shadeNoonGradient;
  Color userNameColor = Colors.black;
  Profile profile;
  List<Notif> notifList = [];

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    checkTimeBackground();
    loadProfile();
    loadNotification();
  }

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

  void loadNotification() async {
    final user = await FirebaseAuth.instance.currentUser();

    final request = await Api().getDio().get<Map<String, dynamic>>(
          '/profile/notification?cache=false',
          options: Options(headers: {'uid': user.uid}),
        );

    final notifs = Notif.fromMapList(request.data['data']);
    setState(() {
      notifList = notifs;
    });
  }

  void loadProfile() async {
    final user = await FirebaseAuth.instance.currentUser();

    final profileResult = await Api().get<Profile>(
      path: '/profile?cache=false',
      dataParser: Profile.fromJson,
      headers: {'uid': user.uid},
    );

    profile = profileResult.data;
    String city = profile.locationName;

    if (city == null || city.isEmpty) {
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        double.tryParse(profile.coordinate.split(',')[0]),
        double.tryParse(profile.coordinate.split(',')[1]),
      );
      if (placemark.length > 0) {
        city = placemark[0].subAdministrativeArea;
      }
    }

    if (city == null || city.isEmpty) city = "Unknown";

    setState(() {
      this.profile = profile.copyWith(locationName: city);
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
        StatusBoard(profile, () => reload()),
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
        launch(
          'https://covid19.prixa.ai/partner/54cf601f-ca6f-4eab-b2fa-052b46f626c7/app/95da3cd5-182c-44c4-a452-d83f045f103b',
        );
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
          profile?.username ?? '...',
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
              profile?.locationName ?? 'Unknown',
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
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                Container(height: 16),
              ],
            ),
            Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: profile?.emblemImgUrl ?? '',
                  width: 42,
                  fit: BoxFit.fitWidth,
                ),
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
              builder: (ctx) => NotificationScreen(notifList),
            ));
          },
          color: Colors.white,
          shape: CircleBorder(),
          child: AppImages.bellSvg.toSvgPicture(),
        ),
        if (notifList.isNotEmpty)
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
