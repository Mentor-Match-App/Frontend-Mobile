import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/Myclass_booking.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/Mysession_booking.dart';
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
            Image.asset('assets/Handoff/logo/LogoMobile.png'),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      changeClass("My Class");
                    },
                    icon: Icon(Icons.menu_book_outlined,
                        color: isClassActive
                            ? ColorStyle().primaryColors
                            : Colors.grey),
                    label: Text("My Class",
                        style: FontFamily().boldText.copyWith(
                            color: isClassActive
                                ? ColorStyle().primaryColors
                                : Colors.grey)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      changeClass("My Session");
                    },
                    icon: Icon(Icons.volume_down_alt,
                        color: isSessionActive
                            ? ColorStyle().primaryColors
                            : Colors.grey),
                    label: Text("My Session",
                        style: FontFamily().boldText.copyWith(
                            color: isSessionActive
                                ? ColorStyle().primaryColors
                                : Colors.grey)),
                  ),
                ],
              ),
            ),
            Divider(
              color: ColorStyle().disableColors,
            ),
            Column(
              children: [
                isClassActive
                    ? MyClassBooking()
                    : isSessionActive
                        ? MySessionBooking()
                        : MyClassBooking(),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
