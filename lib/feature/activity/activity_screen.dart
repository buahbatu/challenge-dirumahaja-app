import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/location/location.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_activity.dart';
import 'package:dirumahaja/feature/activity/info_sholat.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<Activity> resources = [];
  Map<String, dynamic> prayTimes = Map<String, dynamic>();
  String prayLocation = "";

  @override
  void initState() {
    super.initState();
    loadActivities();
    loadPrayer();
  }

  void loadActivities() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    final rawActivity = remoteConfig.getString('productive_activity');
    final jsonActivity = jsonDecode(rawActivity);
    setState(() {
      resources = Activity.fromJsonList(jsonActivity);
    });
  }

  void loadPrayer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    IndonesiaPlace location = await ReverseGeocoder.loadCurrentLocation();

    final locationKey = 'locationName';
    bool shouldLoadNew = false;
    if (!prefs.containsKey(locationKey) ||
        prefs.getString(locationKey) != location.toString()) {
      prefs.setString(locationKey, location.toString());
      shouldLoadNew = true;
    }

    final timeKey = 'prayTime';
    var times = Map<String, dynamic>();
    final time = DateTime.now();

    if (shouldLoadNew) {
      final timeResult = await Dio().get(
        defaultDomain +
            'assets/prayer-times/${location.province}_${location.city}_${time.year.toString()}.json',
      );
      if (timeResult.statusCode != 200) return;

      prefs.setString(timeKey, jsonEncode(timeResult.data));
      times = timeResult.data;
    } else {
      times = jsonDecode(prefs.getString(timeKey));
    }

    final prayer = times['block'][time.month - 1]['schedule'][time.day - 1];
    setState(() {
      prayTimes = prayer;
      prayLocation = location.city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('4DA6EA'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('4DA6EA'),
        title: Text(
          'Mari Produktif',
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          if (prayTimes.isNotEmpty) InfoSholat(prayLocation, prayTimes),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.all(16),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: resources.map((r) => createItem(r)).toList(),
          ),
        ],
      ),
    );
  }

  Card createItem(Activity a) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => launch(a.resPath),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            a.imagePath.toSvgPicture(),
            Text(
              a.title,
              style: GoogleFonts.muli(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
