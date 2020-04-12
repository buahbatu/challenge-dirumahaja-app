import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui show ImageByteFormat, Image;

import 'package:wc_flutter_share/wc_flutter_share.dart';

class ShareScreen extends StatefulWidget {
  final String username;
  final String imagePath;

  const ShareScreen(
    this.username,
    this.imagePath, {
    Key key,
  }) : super(key: key);
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  GlobalKey _globalKey = new GlobalKey();

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

  void shareApp() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      await WcFlutterShare.share(
        sharePopupTitle: 'Bagikan Challenge',
        text: 'Ayok tunjukkan peran mu menghadapi pandemi dengan mengikuti challenge #dirumahaja. ' +
            'Download aplikasinya di playstore atau appstore dengan nama `Ayok #dirumahaja`',
        fileName: 'poster.png',
        mimeType: 'image/png',
        bytesOfFile: pngBytes,
      );
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                getSharedContent(),
                getBackButton(),
              ],
            ),
          ),
          getShareButton(),
        ],
      ),
    );
  }

  Widget getBackButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 32),
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
          shape: CircleBorder(),
          child: Icon(
            Icons.arrow_back,
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
      ],
    );
  }

  Widget getSharedContent() {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
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

  Widget getContent() {
    return Column(
      children: <Widget>[
        Expanded(child: getUserPin()),
        getTextSection(),
        Container(height: 32),
        getDownloadPanel(),
        Container(height: 32),
      ],
    );
  }

  Widget getUserPin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: HexColor('8EC13F'), width: 8),
              ),
            ),
            CachedNetworkImage(
              imageUrl: widget.imagePath,
              width: 112,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
        Container(height: 12),
        Text(
          widget.username,
          style: GoogleFonts.raleway(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: userNameColor == Colors.white
                ? userNameColor
                : AppColor.titleColor.toHexColor(),
          ),
        ),
        Container(height: 8),
        Text(
          'mengajakmu melakukan  \n#bersamakitabisa #dirumahaja',
          textAlign: TextAlign.center,
          style: GoogleFonts.muli(
            color: userNameColor,
            fontWeight: FontWeight.w300,
            fontSize: 14,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }

  Widget getTextSection() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'AYOK',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(8.0, 16.0),
                ),
              ],
            ),
          ),
          Text(
            '#DIRUMAHAJA',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(8.0, 16.0),
                ),
              ],
            ),
          ),
          Text(
            'Challenge',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.black.withOpacity(0.40),
                  offset: Offset(4.0, 8.0),
                ),
              ],
            ),
          ),
        ],
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

  Widget getDownloadPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Download di',
          style: GoogleFonts.raleway(
            fontSize: 14,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: Colors.black.withOpacity(0.40),
                offset: Offset(4.0, 8.0),
              ),
            ],
          ),
        ),
        Text(
          'https://s.id/ayokdirumahaja',
          style: GoogleFonts.raleway(
            fontSize: 14,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: Colors.black.withOpacity(0.40),
                offset: Offset(4.0, 8.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getShareButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      width: double.infinity,
      child: FlatButton(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Text(
          'Bagikan',
          style: GoogleFonts.muli(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        color: HexColor('FF5C76'),
        onPressed: () => shareApp(),
      ),
    );
  }
}
