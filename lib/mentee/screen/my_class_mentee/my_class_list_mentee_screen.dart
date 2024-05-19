import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/my_class_booking.dart';
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
      if (menu == "My Class") {
        isClassActive = true;
        isSessionActive = false;
      } else if (menu == "My Session") {
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isClassActive
                          ? ColorStyle().secondaryColors
                          : ColorStyle().tertiaryColors,
                    ),
                    child: TextButton(
                      onPressed: () {
                        changeClass("My Class");
                      },
                      child: Text(
                        "My Class",
                        style: FontFamily().boldText.copyWith(
                            color: isClassActive
                                ? ColorStyle().whiteColors
                                : ColorStyle().disableColors),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isSessionActive
                          ? ColorStyle().secondaryColors
                          : ColorStyle().tertiaryColors,
                    ),
                    child: TextButton(
                        onPressed: () {
                          changeClass("My Session");
                        },
                        child: Text("My Session",
                            style: FontFamily().boldText.copyWith(
                                color: isSessionActive
                                    ? ColorStyle().whiteColors
                                    : ColorStyle().disableColors))),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                isClassActive
                    ? MyClassBookingMentee()
                    : isSessionActive
                        ? MySessionBooking()
                        : MyClassBookingMentee(),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
