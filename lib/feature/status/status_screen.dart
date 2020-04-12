import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/entity/entity_emblem.dart';
import 'package:dirumahaja/core/entity/entity_profile.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusScreen extends StatefulWidget {
  final Profile profile;
  final VoidCallback onHomeNeedReload;

  const StatusScreen(
    this.profile,
    this.onHomeNeedReload, {
    Key key,
  }) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState(profile);
}

class _StatusScreenState extends State<StatusScreen> {
  Profile profile;
  bool isHomeNeedReload = false;

  _StatusScreenState(this.profile);

  @override
  void initState() {
    super.initState();
    loadAllAmblem();
  }

  List<Emblem> emblemList = [];

  void loadAllAmblem() async {
    final user = await FirebaseAuth.instance.currentUser();
    final request = await Api().getDio().get<Map<String, dynamic>>(
          '/emblem',
          options: Options(headers: {'uid': user.uid}),
        );
    final emblems = Emblem.fromMapList(request.data['data']);

    setState(() {
      emblemList = emblems;
    });
  }

  void loadProfile() async {
    final user = await FirebaseAuth.instance.currentUser();

    final profileResult = await Api().get<Profile>(
      path: '/profile?cache=false',
      dataParser: Profile.fromJson,
      headers: {
        'uid': user.uid,
      },
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

  void selectEmblem(Emblem e) async {
    isHomeNeedReload = true;
    try {
      final user = await FirebaseAuth.instance.currentUser();

      final request = await Api().getDio().put<Map<String, dynamic>>(
            '/emblem/${e.id}',
            options: Options(headers: {'uid': user.uid}),
          );

      loadProfile();
    } catch (error) {
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColor.bgColor.toHexColor(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.bgColor.toHexColor(),
          title: Text(
            'Status Kamu',
            style: GoogleFonts.raleway(
              color: AppColor.titleColor.toHexColor(),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          actions: getAction(context),
          iconTheme: IconThemeData(
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
        body: SingleChildScrollView(child: getContent()),
      ),
      onWillPop: () async {
        if (isHomeNeedReload) widget.onHomeNeedReload();
        return true;
      },
    );
  }

  Column getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            getUserInfo(),
            getUserPin(),
          ],
        ),
        getBannerCard(),
        Container(height: 16),
        getEmblemHint(),
        getOptions(),
      ],
    );
  }

  Align getUserPin() {
    return Align(
      child: createImage(
        profile?.emblemImgUrl ?? '',
        128,
        8,
        HexColor('8EC13F'),
      ),
      alignment: Alignment.topCenter,
    );
  }

  Padding getEmblemHint() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Text(
        'Koleksi mu akan bertambah seiring bertambahnya hari, teman, ataupun energi mu. Ayo semangat!',
        textAlign: TextAlign.center,
        style: GoogleFonts.muli(
          fontSize: 14,
          color: AppColor.bodyColor.toHexColor(),
        ),
      ),
    );
  }

  Widget getOptions() {
    final imageSize = ((MediaQuery.of(context).size.width - 40) / 2) - 122;
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.3,
      padding: const EdgeInsets.all(16),
      physics: NeverScrollableScrollPhysics(),
      children: emblemList.map((e) => getOptionCard(e, imageSize)).toList(),
    );
  }

  Widget getOptionCard(Emblem e, double size) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: InkWell(
        onTap: () => selectEmblem(e),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              createImage(e.imgUrl ?? '', size, 2, Colors.blue),
              Container(height: 12),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.buttonColor.toHexColor(),
                ),
                child: Text(
                  e.name,
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBannerCard() {
    return Container(
      width: 400,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: HexColor('FF5C76'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.bgColor.toHexColor(),
                ),
              ),
              Text(
                'Koleksi Emblem kamu',
                style: GoogleFonts.muli(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.bgColor.toHexColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserInfo() {
    return Container(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(vertical: 58),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(height: 70),
              getStatusBar(),
              Container(height: 24),
              Text(
                profile?.username ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.muli(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Text(
                profile?.locationName ?? '',
                style: GoogleFonts.muli(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Container(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppImages.energySvg.toSvgPicture(width: 10),
                  Container(width: 6),
                  Text(
                    profile?.sessionHealth.toString() ?? '',
                    style: GoogleFonts.muli(color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createImage(
    String path,
    double size,
    double width,
    Color borderColor,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: width),
          ),
        ),
        CachedNetworkImage(
          imageUrl: path,
          width: size - 2 * width,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }

  Widget getStatusBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.buttonColor.toHexColor(),
      ),
      child: Text(
        profile?.emblemName ?? '',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  List<Widget> getAction(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: AppImages.helpSvg.toSvgPicture(
          color: AppColor.titleColor.toHexColor(),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => RuleScreen()),
          );
        },
      ),
    ];
  }
}
