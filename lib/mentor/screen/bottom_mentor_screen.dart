import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/BottomHomeMentor/home_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/MyClass_list_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/community_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/profile_mentor/mentor_profile_screen.dart';
import 'package:mentormatch_apps/widget/bottom_nav.dart';

class BottomNavbarMentorScreen extends StatefulWidget {
  const BottomNavbarMentorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavbarMentorScreen> createState() => _BottomNavbarMentorScreenState();
}

class _BottomNavbarMentorScreenState extends State<BottomNavbarMentorScreen> {
  int _selectedNavbar = 0;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Widget screenBottomNavigation(int index) {
    if (index == 0) {
      return const HomeMentorScreen();
    } else if (index == 1) {
      return MyClassMentorListScreen();
    } else if (index == 2) {
      return CommunityMentorScreen();
    } else {
      return ProfileMentorScreen();
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
