import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/Detail_myClass_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class MyClassBooking extends StatefulWidget {
  MyClassBooking({Key? key}) : super(key: key);

  @override
  State<MyClassBooking> createState() => _MyClassBookingState();
}

class _MyClassBookingState extends State<MyClassBooking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle().tertiaryColors,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.asset(
                      fit: BoxFit.cover,
                      "assets/Handoff/Ilustrator/profile.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "UI/UX Design",
                          style: FontFamily().boldText,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "30 Hari",
                          style: FontFamily().regularText,
                        ),
                        Text(
                          'Mentor ',
                          style: FontFamily().regularText,
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SmallElevatedButton(
                            height: 32,
                            width: 120,
                            title: "Lihat Kelas",
                            style: FontFamily().buttonText.copyWith(
                                  fontSize: 12,
                                  color: ColorStyle().whiteColors,
                                ),
                            onPressed: (){}
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        );
  }
}