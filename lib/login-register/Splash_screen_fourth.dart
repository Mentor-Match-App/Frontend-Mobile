import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login-register/Login_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class SplashScreenFourth extends StatefulWidget {
  SplashScreenFourth({Key? key}) : super(key: key);

  @override
  State<SplashScreenFourth> createState() => _SplashScreenFourthState();
}

class _SplashScreenFourthState extends State<SplashScreenFourth> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: -300,
          right: 0,
          child: ClipPath(
            clipper: HalfCircleClipper(),
            child: Container(
              height: 400,
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
                  height: 180,
                ),
                Image.asset(
                  'assets/Handoff/ilustrator/community.png',
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
                        'Temukan mentor yang berpengalaman dalam tingkat pendidikan Anda, dari SD hingga perguruan tinggi.',
                        style: FontFamily().regularText),
                  ),
                ),
                ElevatedButtonWidget(
                  title: 'Get Started',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            ),
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
