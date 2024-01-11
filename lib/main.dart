import 'package:flutter/material.dart';
import 'package:mentormatch_apps/screen/MyClass/Detail_myClass_screen.dart';
import 'package:mentormatch_apps/screen/MyClass/MyClass_list_screen.dart';
import 'package:mentormatch_apps/screen/MyClass/evalusi_screen.dart';
import 'package:mentormatch_apps/screen/Session/detail_mentor_session.dart';
import 'package:mentormatch_apps/screen/Session/session_screen.dart';
import 'package:mentormatch_apps/screen/bottom_screen.dart';
import 'package:mentormatch_apps/screen/community_screen.dart';
import 'package:mentormatch_apps/screen/login-register/Login_screen.dart';
import 'package:mentormatch_apps/screen/notification_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/detail_mentor_premium_class.dart';
import 'package:mentormatch_apps/screen/login-register/edit_profile.dart';
import 'package:mentormatch_apps/screen/home_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/Karier/Karier_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/Kuliah/Kuliah_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/SD/sd_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/SMA/SMA_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/SMP/SMP_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/premium_class_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/rincihan_kegiatan_screen.dart';
import 'package:mentormatch_apps/screen/profile/mentee_profile_screen.dart';
import 'package:mentormatch_apps/screen/profile/mentor_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNavbarScreen());
  }
}
