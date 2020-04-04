import 'dart:convert';

import 'package:dirumahaja/core/entity/entity_profile.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/dashboard/dashboard_screen.dart';
import 'package:dirumahaja/feature/register/address_screen.dart';
import 'package:dirumahaja/feature/register/challenger_screen.dart';
import 'package:dirumahaja/feature/register/profile_screen.dart';
import 'package:dirumahaja/feature/register/rulebook_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  static const int maxPage = 4;
}

class _RegisterScreenState extends State<RegisterScreen> {
  Profile profile = Profile(isMale: true);

  void updateProfile(Profile profile) {
    this.profile = profile;
  }

  List<Widget> pages;

  List<Widget> getPages() {
    if (pages == null)
      pages = [
        ProfileScreen(
          onSubmit: ({username, age, isMale}) => updateProfile(profile.copyWith(
            username: username,
            age: age,
            isMale: isMale,
          )),
        ),
        AddressScreen(
          onSubmit: (coordinate) =>
              updateProfile(profile.copyWith(coordinate: coordinate)),
        ),
        ChallengerScreen(
          onSubmit: (challenger) =>
              updateProfile(profile.copyWith(challenger: challenger)),
        ),
        RuleBookScreen(),
      ];
    return pages;
  }

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
          child: Icon(
            Icons.arrow_back,
            color: AppColor.titleColor.toHexColor(),
          ),
        ),
      ],
    );
  }

  int currentPage = 0;

  final PageController controller = PageController(initialPage: 0);

  Widget createPages(BuildContext ctx, int order) {
    return getPages()[order];
  }

  void onPageChanged(index) {
    setState(() {
      currentPage = index;
    });
  }

  void saveToPref(Map<String, dynamic> map) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', true);
    pref.setString('profile', jsonEncode(map));
  }

  void doRegister(Profile profile, BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // make sure to create new user
    if (await _auth.currentUser() != null) _auth.signOut();
    final userRegisResult = await _auth.signInAnonymously();
    final uid = userRegisResult.user.uid;

    final profileData = {
      "uid": uid,
      "username": profile.username,
      "coordinate": profile.coordinate,
      "challenger": profile.challenger,
      "male": profile.isMale ? "m" : "f"
    };

    final result = await Api().post(
      path: '/auth/register',
      body: profileData,
      dataParser: null,
    );

    if (result.isSuccess()) {
      saveToPref(profileData);
      onRegisterSuccess();
    } else if (result.meta.errorType == "USER_ALREADY_EXIST") {
      onRegisterError(
        "Username telah terdaftar, silahkan daftar menggunakan username baru",
        context,
      );
    } else {
      onRegisterError(result.meta.errorMessage, context);
    }
  }

  void onRegisterSuccess() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => DashboardScreen()),
      (r) => false,
    );
  }

  void onRegisterError(String msg, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  void onNextClick(BuildContext context) {
    if (currentPage + 1 < RegisterScreen.maxPage) {
      controller.animateToPage(
        currentPage + 1,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      doRegister(profile, context);
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
    return Builder(builder: (context) {
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
            onPressed: () => onNextClick(context),
          ),
        ),
      );
    });
  }
}
