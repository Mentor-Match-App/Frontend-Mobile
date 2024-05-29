import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/premium_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/all_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/my_session_create_mentor.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class MyClassMentorListScreen extends StatefulWidget {
  const MyClassMentorListScreen({Key? key}) : super(key: key);

  @override
  State<MyClassMentorListScreen> createState() =>
      _MyClassMentorListScreenState();
}

class _MyClassMentorListScreenState extends State<MyClassMentorListScreen> {
  bool isAllClassActive = true;
  bool isPremiumClassActive = false;
  bool isSessionActive = false; // Renamed for consistency
  void changeClass(String menu) {
    setState(() {
      if (menu == "Premium Class") {
        isPremiumClassActive = true;
        isSessionActive = false;
        isAllClassActive = false;
      } else if (menu == "My Session") {
        // Corrected the condition
        isPremiumClassActive = false;
        isSessionActive = true;
        isAllClassActive = false;
      } else {
        menu == "All Class";
        isAllClassActive = true;
        isPremiumClassActive = false;

        isSessionActive = false;
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
                    builder: (context) => NotificationMentorScreen(),
                  ),
                );
              },
              icon: Icon(Icons.notifications_none_outlined),
              color: ColorStyle().secondaryColors,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidgetMentor(
                  title: 'search by mentee name,or class name'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 80,
                        height: 38,
                        decoration: isAllClassActive
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
                            changeClass("All Class");
                          },
                          child: Text(
                            "All Class",
                            style: FontFamily().boldText.copyWith(
                                  color: isAllClassActive
                                      ? ColorStyle().whiteColors
                                      : ColorStyle().secondaryColors,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 120,
                        height: 38,
                        decoration: isPremiumClassActive
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
                                  color: isPremiumClassActive
                                      ? ColorStyle().whiteColors
                                      : ColorStyle().secondaryColors,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
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
                            changeClass("My Session");
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
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  isPremiumClassActive
                      ? PremiumClassMentorScreen()
                      : isSessionActive
                          ? MySessionCreate()
                          : isAllClassActive
                              ? AllClassMentorScreen()
                              : PremiumClassMentorScreen()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
