import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/Detail_myClass_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/MyClass_list_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/evalusi_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_mentor_session.dart';
import 'package:mentormatch_apps/mentee/screen/Session/session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/community_mentee__screen.dart';
import 'package:mentormatch_apps/login-register/Login_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/notification_nonaktif_kelas_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/detail_mentor_premium_class.dart';
import 'package:mentormatch_apps/mentee/screen/profile/edit_profile_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/home_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/Karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Kuliah/Kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMP/SMP_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/rincihan_kegiatan_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:mentormatch_apps/mentor/screen/profile_mentor/mentor_profile_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/MyClass_list_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/home_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/detail_myclass_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/evaluasi_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_class.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_session.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/first_form.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/verification_regist.dart';

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
        home: BottomNavbarMentorScreen());
  }
}
