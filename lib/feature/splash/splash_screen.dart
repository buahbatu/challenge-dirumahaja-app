import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    AppImages.blueBg.toSvgPicture();
    return Scaffold(
      backgroundColor: HexColor('FCF8F3'),
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ...getBackgrounds(),
            getForeground(),
          ],
        ),
      ),
    );
  }

  List<Widget> getBackgrounds() {
    return [
      AppImages.pinkBg.toSvgPicture(
        height: 240,
        fit: BoxFit.fitHeight,
      ),
      AppImages.yellowBg.toSvgPicture(
        height: 190,
        fit: BoxFit.fitHeight,
      ),
      AppImages.blueBg.toSvgPicture(
        height: 130,
        fit: BoxFit.fitHeight,
      ),
    ];
  }

  Container getForeground() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          getImageRow(),
        ],
      ),
    );
  }

  Row getImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AppImages.homePerson.toSvgPicture(),
        Container(width: 36),
      ],
    );
  }
}
