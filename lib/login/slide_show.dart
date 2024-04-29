import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login/Splash_screen_fourth.dart';
import 'package:mentormatch_apps/login/splash_screen_second.dart';
import 'package:mentormatch_apps/login/splash_screen_third.dart';
import 'package:mentormatch_apps/style/color_style.dart';

class SlideShow extends StatefulWidget {
  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _pages = [
    SplashScreenSecond(),
    SplashScreenThrid(),
    SplashScreenFourth(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color:
            isActive ? ColorStyle().primaryColors : ColorStyle().disableColors,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: _pages,
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// Contoh halaman untuk ditampilkan dalam slideshow
class SlidePage extends StatelessWidget {
  final Color color;

  SlidePage({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
