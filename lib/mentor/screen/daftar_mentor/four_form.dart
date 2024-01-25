import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/login-register/Login_screen.dart';
import 'package:mentormatch_apps/login-register/register_screen.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/thrid_form.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class FourFormRegistMentorScreen extends StatelessWidget {
  const FourFormRegistMentorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/Handoff/ilustrator/mentor in zoom.png'),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          'Hello Stevenley, \nComplete the form to become a mentor',
                          style: FontFamily().titleText.copyWith(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        TittleTextField(
                          title: "Experience",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Enter your role ",
                        ),
                        const TextFieldWidget(
                          hintText: "Company name",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButtonWidget(
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
                          title: "Next",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
