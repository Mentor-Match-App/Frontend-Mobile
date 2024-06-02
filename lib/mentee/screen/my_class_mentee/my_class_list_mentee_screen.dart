import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/all_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/my_session_booking.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/premium_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class MyClassMenteeListScreen extends StatefulWidget {
  MyClassMenteeListScreen({Key? key}) : super(key: key);

  @override
  State<MyClassMenteeListScreen> createState() =>
      _MyClassMenteeListScreenState();
}

class _MyClassMenteeListScreenState extends State<MyClassMenteeListScreen> {
  int _unreadNotificationsCount = 0;
  final NotificationService _notificationService = NotificationService();

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

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
  }

  bool isAllClassActive = true;
  bool isSessionActive = false; // Renamed for consistency
  bool isPremiumClassActive = false;

  void changeClass(String menu) {
    setState(() {
      if (menu == "All Class") {
        isAllClassActive = true;
        isSessionActive = false;
        isPremiumClassActive = false;
      } else if (menu == "Session") {
        // Corrected the condition
        isAllClassActive = false;
        isSessionActive = true;
        isPremiumClassActive = false;
      } else if (menu == "Premium Class") {
        isAllClassActive = false;
        isSessionActive = false;
        isPremiumClassActive = true;
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
                        builder: (context) => NotificationMenteeScreen(),
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
      body: ListView(children: [
        Column(
          children: [
            SearchBarWidgetMentee(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
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
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                isAllClassActive
                    ? AllClassMenteeScreen()
                    : isPremiumClassActive
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
