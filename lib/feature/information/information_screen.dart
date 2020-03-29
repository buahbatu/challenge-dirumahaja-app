import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/feature/information/statistic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatelessWidget {
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
            'https://www.covid19.bnpb.go.id/situasi-virus-corona/',
          ),
          StatisticItem(),
          Container(height: 16),
          getTitle('Info Penting Lainnya', '', ''),
          getInfoCard(
            getHospitalGradient(),
            'Yakin Terjangkit?',
            'Tenang dan jangan panik, segera cek RS Rujukan di sekitar mu',
            'Cek RS Rujukan',
            'https://katadata.co.id/berita/2020/03/12/daftar-terbaru-132-rumah-sakit-rujukan-virus-corona',
          ),
          getInfoCard(
            getNewsGradient(),
            "What's happening?",
            'Baca berita NO HOAX terbaru mengenai Covid19 di sekitar mu.',
            'Lihat Berita',
            'https://kumparan.com/topic/virus-corona-di-indonesia',
          ),
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

  Widget getInfoCard(
    Gradient gradient,
    String title,
    String desc,
    String action,
    String url,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: gradient,
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
              child: getDescription(title, desc),
            ),
          ),
          Flexible(
            flex: 5,
            child: getHospitalButton(action, url),
          ),
        ],
      ),
    );
  }

  Gradient getNewsGradient() {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [HexColor('623AA2'), HexColor('F97794')],
    );
  }

  Gradient getHospitalGradient() {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [HexColor('4BA4E8'), HexColor('66C9E8')],
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
            fontSize: 12,
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
