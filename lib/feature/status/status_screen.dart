import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final bgColor = HexColor('F0F6FB');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
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
    );
  }

  Column getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            getUserInfo(),
            Align(
              child: createImage(AppImages.heroPng, 128, 8, HexColor('8EC13F')),
              alignment: Alignment.topCenter,
            ),
          ],
        ),
        getBannerCard(),
        Container(height: 16),
        getEmblemHint(),
        getOptions(),
      ],
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
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.3,
      padding: const EdgeInsets.all(16),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        getOptionCard(),
        getOptionCard(),
        getOptionCard(),
      ],
    );
  }

  Widget getOptionCard() {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              createImage(AppImages.heroPng, 64, 2, Colors.blue),
              Container(height: 8),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.buttonColor.toHexColor(),
                ),
                child: Text(
                  'Corona Hero',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 18,
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
    return Card(
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
              decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
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
              decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUserInfo() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(58),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(height: 70),
            getStatusBar(),
            Container(height: 24),
            Text(
              'NisaBucinSelalu',
              textAlign: TextAlign.center,
              style: GoogleFonts.muli(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              'Bandung',
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
                  '3',
                  style: GoogleFonts.muli(color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createImage(
      String path, double size, double width, Color borderColor) {
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
        path.toPngImage(width: size - 2 * width),
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
          fontSize: 32,
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
