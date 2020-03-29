import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/dashboard/dashboard_screen.dart';
import 'package:dirumahaja/feature/register/address_screen.dart';
import 'package:dirumahaja/feature/register/challenger_screen.dart';
import 'package:dirumahaja/feature/register/profile_screen.dart';
import 'package:dirumahaja/feature/register/rulebook_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  static const int maxPage = 4;

  final pages = [
    ProfileScreen(),
    AddressScreen(),
    ChallengerScreen(),
    RuleBookScreen(),
  ];
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColor.skyGradient),
        child: Stack(
          children: <Widget>[
            ...getBackgrounds(),
            PageView.builder(
              itemBuilder: createPages,
              itemCount: RegisterScreen.maxPage,
              controller: controller,
              onPageChanged: onPageChanged,
            ),
            getBackButton(),
            getNextButton()
          ],
        ),
      ),
    );
  }

  Widget getBackButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 32),
        RaisedButton(
          onPressed: onBackClick,
          color: Colors.white,
          shape: CircleBorder(),
          child: AppImages.arrowLeftSvg.toSvgPicture(),
        ),
      ],
    );
  }

  int currentPage = 0;

  final PageController controller = PageController(initialPage: 0);

  Widget createPages(BuildContext ctx, int order) {
    return widget.pages[order];
  }

  void onPageChanged(index) {
    setState(() {
      currentPage = index;
    });
  }

  void onNextClick() {
    if (currentPage + 1 < RegisterScreen.maxPage) {
      controller.animateToPage(
        currentPage + 1,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => DashboardScreen()),
        (r) => false,
      );
    }
  }

  void onBackClick() {
    if (currentPage - 1 >= 0) {
      controller.animateToPage(
        currentPage - 1,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
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
    ];
  }

  Widget getNextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 52,
        width: double.infinity,
        margin: EdgeInsets.all(16),
        child: RaisedButton(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            currentPage < RegisterScreen.maxPage - 1
                ? 'Lanjut'
                : 'Oke, Aku Siap!',
            style: GoogleFonts.muli(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          color: AppColor.buttonColor.toHexColor(),
          onPressed: onNextClick,
        ),
      ),
    );
  }
}
