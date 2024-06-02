import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/all_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/my_session_create_mentor.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/premium_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
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
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
  }

  Future<void> _fetchUnreadNotificationsCount() async {
    try {
      final notifications =
          await _notificationService.fetchNotificationsForCurrentUser();
      final unreadCount =
          notifications.where((notification) => !notification.isRead!).length;
      setState(() {
        _unreadNotificationsCount = unreadCount;
      });
    } catch (e) {
      print(e); // Handle error appropriately
    }
  }

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
      backgroundColor: ColorStyle().whiteColors,
      appBar: AppBar(
        backgroundColor: ColorStyle().whiteColors,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/Handoff/logo/LogoMobile.png',
              width: 120,
              height: 120,
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationMentorScreen(),
                      ),
                    ).then((_) {
                      _fetchUnreadNotificationsCount(); // Fetch the unread count when returning to this screen
                    });
                  },
                  icon: Icon(Icons.notifications_none_outlined),
                  color: ColorStyle().secondaryColors,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$_unreadNotificationsCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            )
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
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
                      padding: const EdgeInsets.all(6.0),
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
                      padding: const EdgeInsets.all(6.0),
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
