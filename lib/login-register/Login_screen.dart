import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentormatch_apps/login-register/choose_role_screen.dart';
import 'package:mentormatch_apps/login-register/login_service.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggingIn = false;

  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoggingIn = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Mengambil ID token dari Firebase Auth
          String? idToken = await user.getIdToken();
          print('ID Token: $idToken');

          // Membuat instance AuthService dan memanggil loginUser
          AuthService authService = AuthService();
          await authService.loginUser(idToken!);

          // Cek data yang disimpan di SharedPreferences
          Map<String, String?> userData = await AuthService.getUserData();
          // print("Data yang disimpan:");
          // print(
          //     "UserID: ${userData['userId']}, Token: ${userData['token']}, Name: ${userData['name']}, Email: ${userData['email']}, Photo URL: ${userData['photoUrl']}, User Type: ${userData['userType']}");

          // Navigasi ke halaman lain setelah login berhasil
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ChooseRoleScreen()));
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login failed: $e"),
        ),
      );
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          // Widget UI Login
          Padding(
            padding: const EdgeInsets.all(20),
            child: loginUI(),
          ),
        ],
      ),
    );
  }

  Widget loginUI() {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/Handoff/ilustrator/first screen.png'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Widget UI teks dan tombol login
                welcomeText(),
                loginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Selamat Datang di Aplikasi Mentor Terbaik',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Color(0xff0A1737),
            fontSize: 20,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 12),
        Text(
          'Dengan Mentormatch, Anda dapat terhubung dengan mentor yang berpengalaman dan inspiratif di berbagai bidang.',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget loginButton() {
    return ElevatedButtonWidget(
      onPressed: _isLoggingIn
          ? null
          : () async {
              await signInWithGoogle();
            },
      title: "Login with Google Account",
    );
  }
}
