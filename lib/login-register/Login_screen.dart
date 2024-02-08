import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentormatch_apps/login-register/choose_role_screen.dart';
import 'package:mentormatch_apps/login-register/register_screen.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount? _currentUser;

  // void signInSilently() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signInSilently();
  //     // Handle signed in user (googleSignInAccount)
  //   } catch (error) {
  //     // Handle error
  //   }
  // }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _currentUser = event;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _currentUser == null
              ? Image.asset('assets/Handoff/logo/LogoMobile.png')
              : Text('Dasboard'),
        ),
        body: _currentUser == null
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('assets/Handoff/ilustrator/login.png'),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
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
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButtonWidget(
                                        onPressed: () => _googleSignIn.signIn(),
                                        title: "Login with Google Account",
                                      ),
                                      Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('tidak punya akun?',
                                                    style: FontFamily()
                                                        .regularText),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ChooseRoleScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text('register',
                                                      style: FontFamily()
                                                          .boldText),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                child: ListTile(
                  leading: GoogleUserCircleAvatar(identity: _currentUser!),
                  title: Text(_currentUser!.displayName ?? ''),
                  subtitle: Text(_currentUser!.email),
                ),
              ));
  }
}
