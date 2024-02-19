import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/register_form.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan ini dipanggil pertama
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();
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
        home: RegisterMentorScreen());
  }
}
