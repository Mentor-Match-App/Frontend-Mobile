import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login-register/Login_screen.dart';
import 'package:mentormatch_apps/login-register/choose_role_screen.dart';
import 'package:mentormatch_apps/mentee/screen/home_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/home_mentor_screen.dart';

import 'firebase_options.dart';
import 'preferences/ preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();

  // Periksa apakah token ada
  String? token = await UserPreferences.getToken();
  // Inisialisasi initialScreen sebagai LoginScreen sebagai default
  Widget initialScreen = LoginScreen();

  if (token != null) {
    // Jika token ada, periksa userType
    String? userType = await UserPreferences.getUserType();
    switch (userType) {
      case 'Mentee':
        initialScreen = HomeMenteeScreen();
        break;
      case 'Mentor':
        initialScreen = HomeMentorScreen();
        break;
      // Tambahkan lebih banyak kasus jika ada userType lain
      default:
        // Jika userType tidak dikenali, tampilkan ChooseRoleScreen atau layar login
        initialScreen = ChooseRoleScreen();
        break;
    }
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorMatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
