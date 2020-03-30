import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/dashboard/dashboard_screen.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getStatusBar(),
                  Container(height: 16),
                  createImage(AppImages.heroPng),
                  Container(height: 24),
                  getUserInfo(),
                  Text(
                    'kamu bisa ganti emblem mu saat ini dengan klik salah satu dari koleksi emblem kamu',
                    style: GoogleFonts.muli(color: Colors.black87),
                  ),
                  Text(
                    'Semua Emblem kamu',
                    style: GoogleFonts.muli(color: Colors.black87),
                  ),
                  Text(
                    'PahlawanPandemi',
                    style: GoogleFonts.muli(color: Colors.black87),
                  ),
                  Container(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getUserInfo() {
    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.buttonColor.toHexColor(),
      ),
      child: Column(
        children: <Widget>[
          Container(height: 80),
          Text(
            'NisaBucinSelalu',
            textAlign: TextAlign.center,
            style: GoogleFonts.muli(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Bandung',
            style: GoogleFonts.muli(color: Colors.black87),
          ),
          Text(
            '19 Tahun',
            style: GoogleFonts.muli(color: Colors.black87),
          ),
          Text(
            'Perempuan',
            style: GoogleFonts.muli(color: Colors.black87),
          ),
          Text(
            '3',
            style: GoogleFonts.muli(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget createImage(String path) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: HexColor('8EC13F'), width: 8),
          ),
        ),
        path.toPngImage(width: 112),
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
        'Corona Hero',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 38,
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
