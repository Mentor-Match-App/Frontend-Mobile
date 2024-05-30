import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/premium_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/my_session_booking.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class MyClassMenteeListScreen extends StatefulWidget {
  MyClassMenteeListScreen({Key? key}) : super(key: key);

  @override
  State<MyClassMenteeListScreen> createState() =>
      _MyClassMenteeListScreenState();
}

class _MyClassMenteeListScreenState extends State<MyClassMenteeListScreen> {
  bool isClassActive = true;
  bool isSessionActive = false; // Renamed for consistency

  void changeClass(String menu) {
    setState(() {
      if (menu == "Premium Class") {
        isClassActive = true;
        isSessionActive = false;
      } else if (menu == "Session") {
        // Corrected the condition
        isClassActive = false;
        isSessionActive = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/Handoff/logo/LogoMobile.png',
              width: 120,
              height: 120,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationMenteeScreen(),
                  ),
                );
              },
              icon: Icon(Icons.notifications_none_outlined),
              color: ColorStyle().secondaryColors,
            ),
          ],
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 38,
                    decoration: isClassActive
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorStyle().secondaryColors,
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: ColorStyle().secondaryColors,
                            ),
                          ),
                    child: TextButton(
                      onPressed: () {
                        changeClass("Premium Class");
                      },
                      child: Text(
                        "Premium Class",
                        style: FontFamily().boldText.copyWith(
                              color: isClassActive
                                  ? ColorStyle().whiteColors
                                  : ColorStyle().secondaryColors,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    height: 38,
                    decoration: isSessionActive
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorStyle().secondaryColors,
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: ColorStyle().secondaryColors,
                            ),
                          ),
                    child: TextButton(
                      onPressed: () {
                        changeClass("Session");
                      },
                      child: Text(
                        "Session",
                        style: FontFamily().boldText.copyWith(
                              color: isSessionActive
                                  ? ColorStyle().whiteColors
                                  : ColorStyle().secondaryColors,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                isClassActive
                    ? PremiumClassMenteeScreen()
                    : isSessionActive
                        ? MySessionBooking()
                        : PremiumClassMenteeScreen(),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
