import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/MyClass_list_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/community_mentee__screen.dart';
import 'package:mentormatch_apps/login-register/Login_screen.dart';
import 'package:mentormatch_apps/mentee/screen/home_screen_mentee.dart';
import 'package:mentormatch_apps/mentee/screen/profile/edit_profile_mentee_screen.dart';

import 'package:mentormatch_apps/login-register/register_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:mentormatch_apps/widget/bottom_nav.dart';

class BottomNavbarMenteeScreen extends StatefulWidget {
  const BottomNavbarMenteeScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavbarMenteeScreen> createState() =>
      _BottomNavbarMenteeScreenState();
}

class _BottomNavbarMenteeScreenState extends State<BottomNavbarMenteeScreen> {
  int _selectedNavbar = 0;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Widget screenBottomNavigation(int index) {
    if (index == 0) {
      return HomeMenteeScreen();
    } else if (index == 1) {
      return MyClassMenteeListScreen();
    } else if (index == 2) {
      return CommunityMenteeScreen();
    } else {
      return ProfileMenteeScreen();
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
