import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/MyClass_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/MyPremiumClass_list_mentor.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/MySessionCreate_mentor.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class MyClassMentorListScreen extends StatefulWidget {
  const MyClassMentorListScreen({Key? key}) : super(key: key);

  @override
  State<MyClassMentorListScreen> createState() =>
      _MyClassMentorListScreenState();
}

class _MyClassMentorListScreenState extends State<MyClassMentorListScreen> {
  bool isPremiumClassActive = false;
  bool isClassActive = true;
  bool isSessionActive = false; // Renamed for consistency
  void changeClass(String menu) {
    setState(() {
      if (menu == "My Class") {
        isClassActive = true;
        isSessionActive = false;
        isPremiumClassActive = false;
      } else if (menu == "My Session") {
        // Corrected the condition
        isClassActive = false;
        isSessionActive = true;
        isPremiumClassActive = false;
      } else {
        menu == "My Premium Class";
        isPremiumClassActive = true;
        isClassActive = false;

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
              Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isPremiumClassActive
                                ? ColorStyle().secondaryColors
                                : ColorStyle().tertiaryColors,
                          ),
                          child: TextButton(
                              onPressed: () {
                                changeClass("My Premium Class");
                              },
                              child: Text("Premium Class",
                                  style: FontFamily().boldText.copyWith(
                                      color: isPremiumClassActive
                                          ? ColorStyle().whiteColors
                                          : ColorStyle().disableColors))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
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
                      ),
                      
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  isClassActive
                      ? MyClassCreate()
                      : isSessionActive
                          ? MySessionCreate()
                          : isPremiumClassActive
                              ? MyPremiumClassMentorScreen()
                              : MyClassCreate()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
