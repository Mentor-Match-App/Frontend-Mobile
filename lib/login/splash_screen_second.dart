import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login/Splash_screen_fourth.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class SplashScreenSecond extends StatefulWidget {
  SplashScreenSecond({Key? key}) : super(key: key);

  @override
  State<SplashScreenSecond> createState() => _SplashScreenSecondState();
}

class _SplashScreenSecondState extends State<SplashScreenSecond> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -300,
          left: -300,
          right: 0,
          child: ClipPath(
            clipper: HalfCircleClipper(),
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                color: ColorStyle().tertiaryColors,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Image.asset(
                  'assets/Handoff/ilustrator/looking mentor.png',
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: ColorStyle().disableColors,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                        'Temukan mentor yang sesuai dengan minat, keahlian, dan pengalaman Anda.',
                        style: FontFamily().regularText),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 40,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SplashScreenFourth()));
            },
            child: Text('Skip',
                style: FontFamily().boldText.copyWith(
                    color: ColorStyle().secondaryColors, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
