import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/feature/register/rulebook_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  static const int maxPage = 4;

  final pages = [
    RuleBookScreen(),
    RuleBookScreen(),
    RuleBookScreen(),
    RuleBookScreen(),
  ];
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    AppImages.blueBg.toSvgPicture();
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ...getBackgrounds(),
            PageView.builder(
              itemBuilder: createPages,
              itemCount: RegisterScreen.maxPage,
              controller: controller,
              onPageChanged: onPageChanged,
            ),
            getNextButton()
          ],
        ),
      ),
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
    controller.animateToPage(
      (currentPage + 1 < RegisterScreen.maxPage)
          ? currentPage + 1
          : currentPage,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> getBackgrounds() {
    return [
      AppImages.pinkBg.toSvgPicture(
        height: 240,
        color: HexColor('FFD4D2'),
        fit: BoxFit.fitHeight,
      ),
      AppImages.yellowBg.toSvgPicture(
        height: 190,
        color: HexColor('FBEDC3'),
        fit: BoxFit.fitHeight,
      ),
      AppImages.blueBg.toSvgPicture(
        height: 130,
        color: HexColor('A6D2F4'),
        fit: BoxFit.fitHeight,
      ),
    ];
  }

  Widget getNextButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(0),
      height: 52,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Text(currentPage < RegisterScreen.maxPage - 1
            ? 'Next'
            : 'Mulai Challenge!'),
        textColor: Colors.white,
        color: HexColor('504658'),
        onPressed: onNextClick,
      ),
    );
  }
}
