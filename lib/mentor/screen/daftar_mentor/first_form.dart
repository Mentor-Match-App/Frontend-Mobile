import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/second_form.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class FirstFormRegistMentorScreen extends StatelessWidget {
  const FirstFormRegistMentorScreen({Key? key}) : super(key: key);

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
                          title: "What your gender",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Prempuan/Laki-laki",
                        ),
                        TittleTextField(
                          title: "Job/Tittle",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Enter Your Job Title",
                        ),
                        TittleTextField(
                          title: "Company",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Enter Your Company",
                        ),
                        TittleTextField(
                          title: "Location",
                          color: ColorStyle().secondaryColors,
                        ),
                        const TextFieldWidget(
                          hintText: "Enter Your Location",
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
                                    const SecondFormRegistMentorScreen(),
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
