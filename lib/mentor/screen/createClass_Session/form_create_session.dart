import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/home_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/calender_textfield.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class FormCreateSessionScreen extends StatefulWidget {
  FormCreateSessionScreen({Key? key}) : super(key: key);

  @override
  State<FormCreateSessionScreen> createState() =>
      _FormCreateSessionScreenState();
}

class _FormCreateSessionScreenState extends State<FormCreateSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Session"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TittleTextField(
                  title: "Topic Session",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "input your topic session",
                ),
                TittleTextField(
                  title: "Tanggal Session",
                  color: ColorStyle().secondaryColors,
                ),
                CalendarTextField(),
                TittleTextField(
                  title: "Jam Session",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "14.00-15.00",
                ),
                TittleTextField(
                  title: "Kapasitas Session",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "maxsimum 100 person",
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeMentorScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  title: "Kirim",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
