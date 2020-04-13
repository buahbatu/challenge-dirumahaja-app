import 'dart:convert';
import 'package:dirumahaja/core/entity/entity_information.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/feature/information/statistic_item.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  List<Information> informations = [];

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    final rawRules = remoteConfig.getString('other_news');
    final jsonRules = jsonDecode(rawRules);
    setState(() {
      informations = Information.fromJsonList(jsonRules);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Update Corona',
          style: GoogleFonts.raleway(
            color: AppColor.titleColor.toHexColor(),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColor.titleColor.toHexColor(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          getTitle(
            'Statistik Hari Ini',
            'Lihat Selengkapnya',
            'https://www.covid19.go.id/situasi-virus-corona/',
          ),
          StatisticItem(),
          Container(height: 16),
          getTitle('Info Penting Lainnya', '', ''),
          ...informations.map((i) => getInfoCard(i)).toList(),
        ],
      ),
    );
  }

  Widget getTitle(String title, String action, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.muli(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          if (action.isNotEmpty)
            InkWell(
              onTap: () => launch(url),
              child: Text(
                action,
                style: GoogleFonts.muli(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColor.titleColor.toHexColor(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget getInfoCard(Information info) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: info.gradient,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 21,
              ),
              child: getDescription(info.title, info.subtitle),
            ),
          ),
          Flexible(
            flex: 5,
            child: getHospitalButton(info.action, info.link),
          ),
        ],
      ),
    );
  }

  Column getDescription(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.muli(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(height: 12),
        Text(
          desc,
          style: GoogleFonts.muli(
            color: Colors.white,
            fontSize: 12,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Container getHospitalButton(String title, String url) {
    return Container(
      padding: const EdgeInsets.all(21),
      width: double.infinity,
      child: FlatButton(
        child: Text(
          title,
          style: GoogleFonts.muli(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white),
        ),
        onPressed: () => launch(url),
      ),
    );
  }
}
