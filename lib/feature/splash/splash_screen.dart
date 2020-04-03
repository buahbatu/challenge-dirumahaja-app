import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/dashboard/dashboard_screen.dart';
import 'package:dirumahaja/feature/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  SharedPreferences pref;

  _SplashScreenState({this.pref});

  @override
  void initState() {
    super.initState();

    checkLoginState();
    showButton();
  }

  void showButton() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _heightButton = 52;
      _widthButton = double.infinity;
    });
  }

  double _heightButton = 0;
  double _widthButton = 0;

  void goToDashboard() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => DashboardScreen()),
      (r) => false,
    );
  }

  void goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => RegisterScreen()),
    );
  }

  void checkLoginState() async {
    await Future.delayed(Duration(seconds: 2));
    if (pref == null) pref = await SharedPreferences.getInstance();
    final isLogin =
        pref.containsKey('isLogin') ? pref.getBool('isLogin') : false;

    if (isLogin) {
      goToDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColor.skyGradient),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ...getBackgrounds(),
            getTextSection(),
            getLoadingKit(),
            getNextButton()
          ],
        ),
      ),
    );
  }

  List<Widget> getBackgrounds() {
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: AppImages.homeBgPng.toPngImage(
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
    ];
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
              fontSize: 36,
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
              fontSize: 46,
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
          Container(height: 18),
          Text(
            'Tetap aman bantu ringankan beban \n#bersamakitabisa #dirumahaja',
            textAlign: TextAlign.center,
            style: GoogleFonts.muli(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget getNextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedSize(
        duration: Duration(milliseconds: 800),
        curve: Curves.decelerate,
        child: Container(
          height: _heightButton,
          width: _widthButton,
          margin: EdgeInsets.all(16),
          child: RaisedButton(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Ayo Ikuti!',
              style: GoogleFonts.muli(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            textColor: Colors.white,
            color: AppColor.buttonColor.toHexColor(),
            onPressed: () => goToRegister(),
          ),
        ),
        vsync: this,
      ),
    );
  }

  Align getLoadingKit() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 84,
        child: SpinKitChasingDots(
          size: 30,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index.isEven
                    ? HexColor('CCE7FF')
                    : AppColor.buttonColor.toHexColor(),
              ),
            );
          },
        ),
      ),
    );
  }
}
