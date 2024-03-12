import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mentormatch_apps/login-register/Login_screen.dart';
import 'package:mentormatch_apps/mentee/provider/review_mentor_provider.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/provider/create_class_provider.dart';
import 'package:mentormatch_apps/mentor/provider/create_session_provider.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/MyClass_list_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/edit_class_rejected.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/evaluasi/list_evaluasi_mentee.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_class.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                CreateSessionProvider()), // MyClassProvider yang kita bicarakan
        ChangeNotifierProvider(
            create: (_) =>
                CreateClassProvider()), // MyClassProvider yang kita bicarakan
        ChangeNotifierProvider(
            create: (_) =>
                ReviewProvider()), // ReviewProvider yang kita bicarakan
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            BottomNavbarMenteeScreen(), // Pastikan ini adalah widget awal yang Anda inginkan
      ),
    );
  }
}
