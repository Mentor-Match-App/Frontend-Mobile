import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/fcm_service.dart';
import 'package:mentormatch_apps/login/login_screen.dart';
import 'package:mentormatch_apps/mentee/provider/review_mentor_provider.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/provider/create_class_provider.dart';
import 'package:mentormatch_apps/mentor/provider/create_session_provider.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/verification_regist.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FCMService.initialize();

  await UserPreferences.init();

  final isLoggedIn = UserPreferences.isLoggedIn();
  final userType = UserPreferences.getUserType();

// print user type
  print('User type: $userType');

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    userType: userType,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userType;

  const MyApp({super.key, required this.isLoggedIn, this.userType});

  @override
  Widget build(BuildContext context) {
    Widget homeScreen = LoginScreen();
    if (isLoggedIn) {
      switch (userType) {
        case 'Mentee':
          homeScreen = BottomNavbarMenteeScreen(); // Layar awal untuk mentee
          break;
        case 'Mentor':
          homeScreen = BottomNavbarMentorScreen(); // Layar awal untuk mentor
          break;
        case 'PendingMentor' || 'RejectedMentor':
          homeScreen = VerificationFormRegistScreen(); // Layar awal untuk admin
          break;
        default:
          homeScreen = LoginScreen(); // Jika userType tidak dikenali
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateSessionProvider()),
        ChangeNotifierProvider(create: (_) => CreateClassProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: homeScreen,
      ),
    );
  }
}
