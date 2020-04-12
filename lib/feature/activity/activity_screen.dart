import 'dart:convert';

import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_activity.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<Activity> resources = [];

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  void loadActivities() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    final rawActivity = remoteConfig.getString('productive_activity');
    print(rawActivity);
    final jsonActivity = jsonDecode(rawActivity);
    setState(() {
      resources = Activity.fromJsonList(jsonActivity);
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
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: resources.map((r) => createItem(r)).toList(),
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
