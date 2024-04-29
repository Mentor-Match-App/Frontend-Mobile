import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login/login_screen.dart';
import 'package:mentormatch_apps/login/register_screen.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/thrid_form.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class SecondFormRegistMentorScreen extends StatelessWidget {
  const SecondFormRegistMentorScreen({Key? key}) : super(key: key);

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
                          title: "Skill",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Enter your skill",
                        ),
                        TittleTextField(
                          title: "Linkedln",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Enter your link linkedln",
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
                                    const ThridFormRegistMentorScreen(),
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
