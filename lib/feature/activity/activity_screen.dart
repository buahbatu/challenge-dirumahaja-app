import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_activity.dart';
import 'package:dirumahaja/feature/activity/info_sholat.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<String> loadCurrentLocation(Map<String, dynamic> locations) async {
    final geolocator = Geolocator();
    final readPosition = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String province = "";
    String city = "";
    double distance = -1;

    for (final prov in locations.keys) {
      Map<String, dynamic> tempProv = locations[prov];
      for (final tempCity in tempProv.keys) {
        final tempDistance = await geolocator.distanceBetween(
          readPosition.latitude,
          readPosition.longitude,
          tempProv[tempCity]['latitude'],
          tempProv[tempCity]['longitude'],
        );
        if (distance == -1) {
          distance = tempDistance;
          province = prov;
          city = tempCity;
        } else if (tempDistance <= distance) {
          distance = tempDistance;
          province = prov;
          city = tempCity;
        }
      }
    }

    return "$province|$city";
  }

  void loadPrayer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final locationListKey = 'locationNameList';

    var locations = Map<String, dynamic>();
    if (prefs.containsKey(locationListKey)) {
      locations = jsonDecode(prefs.getString(locationListKey));
    } else {
      final locationsResult = await Dio()
          .get(defaultDomain + '/assets/location-list/location.json');

      if (locationsResult.statusCode != 200) return;
      prefs.setString(locationListKey, jsonEncode(locationsResult.data));
      locations = locationsResult.data;
    }

    final locationKey = 'locationName';
    String location = await loadCurrentLocation(locations);
    if (location.isEmpty) return;

    bool shouldLoadNew = false;
    if (!prefs.containsKey(locationKey) ||
        prefs.getString(locationKey) != location) {
      prefs.setString(locationKey, location);
      shouldLoadNew = true;
    }

    final timeKey = 'prayTime';
    var times = Map<String, dynamic>();
    final time = DateTime.now();
    final province = location.split('|')[0].toUpperCase();
    final city = location.split('|')[1].toUpperCase();
    if (shouldLoadNew) {
      final timeResult = await Dio().get(defaultDomain +
          'assets/prayer-times/${province}_${city}_${time.year.toString()}.json');
      if (timeResult.statusCode != 200) return;

      prefs.setString(timeKey, jsonEncode(timeResult.data));
      times = timeResult.data;
    } else {
      times = jsonDecode(prefs.getString(timeKey));
    }

    final prayer = times['block'][time.month - 1]['schedule'][time.day - 1];
    setState(() {
      prayTimes = prayer;
      prayLocation = city;
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
