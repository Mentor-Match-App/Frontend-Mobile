import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/community_mentee__screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/Karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Kuliah/Kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMP/SMP_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/service/example_mentors/ui_mentor_example.dart';

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
        home: MentorKuliah());
  }
}
