import 'package:flutter/material.dart';
import 'package:mentormatch_apps/screen/login-register/Login_screen.dart';
import 'package:mentormatch_apps/screen/login-register/edit_profile.dart';
import 'package:mentormatch_apps/screen/home_screen.dart';
import 'package:mentormatch_apps/screen/login-register/register_screen.dart';
import 'package:mentormatch_apps/widget/bottom_nav.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int _selectedNavbar = 0;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Widget screenBottomNavigation(int index) {
    if (index == 0) {
      return const HomeScreen();
    } else if (index == 1) {
      return const RegisterScreen();
    } else if (index == 2) {
      return const LoginScreen();
    } else {
      return const ChangeProfileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        child: screenBottomNavigation(_selectedNavbar),
      ),
      bottomNavigationBar: BottomNavbarWidget(
        currentIndex: _selectedNavbar,
        onTap: _changeSelectedNavbar,
      ),
    );
  }
}
