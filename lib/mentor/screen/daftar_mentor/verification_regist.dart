import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class VerificationFormRegistScreen extends StatefulWidget {
  VerificationFormRegistScreen({Key? key}) : super(key: key);

  @override
  State<VerificationFormRegistScreen> createState() =>
      _VerificationFormRegistScreenState();
}

class _VerificationFormRegistScreenState
    extends State<VerificationFormRegistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset('assets/Handoff/ilustrator/verification.png'),
              const SizedBox(height: 12),
              Text(
                'Terima kasih telah mendaftar sebagai mentor di MentorMatch. ',
                style: FontFamily().titleText.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Proses verifikasi memerlukan waktu paling lama 3 hari  untuk memastikan bahwa setiap mentor memenuhi standar kualitas yang telah ditetapkan. Anda dapat mengakses aplikasi setelah pesan verifikasi masuk kedalam email anda. Kami sangat menghargai kesabaran Anda selama proses ini.',
                style: FontFamily().regularText,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextButton(
                  onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavbarMenteeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                  child:  Text("Back to Home", style: FontFamily().buttonText.copyWith(color: ColorStyle().primaryColors),),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
