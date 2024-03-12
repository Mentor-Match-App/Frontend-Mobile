import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login-register/Slide_show.dart';

class SplashScreenFirst extends StatefulWidget {
  @override
  _SplashScreenFirstState createState() => _SplashScreenFirstState();
}

class _SplashScreenFirstState extends State<SplashScreenFirst> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SlideShow()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
    );
  }
}
