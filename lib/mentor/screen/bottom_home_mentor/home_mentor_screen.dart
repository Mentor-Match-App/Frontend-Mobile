import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/create_class_and_session/form_create_session.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syarat_ketentuan_daftar_mentor/persetujuan_1.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class HomeMentorScreen extends StatefulWidget {
  const HomeMentorScreen({Key? key}) : super(key: key);

  @override
  State<HomeMentorScreen> createState() => _HomeMentorScreenState();
}

class _HomeMentorScreenState extends State<HomeMentorScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/Handoff/logo/LogoMobile.png'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Build Your Awesome Class",
                  style: FontFamily().regularText.copyWith(
                        fontSize: 14,
                        color: ColorStyle().secondaryColors,
                      ),
                ),
              ),
              SearchBarWidget(title: 'search'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorStyle()
                            .blackColors
                            .withOpacity(0.3), // Warna shadow dengan opacity
                        spreadRadius: 1, // Radius penyebaran shadow
                        blurRadius: 2, // Radius blur shadow
                        offset: Offset(0, 2), // Posisi offset shadow (x, y)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              "Tingkatkan Masa Depan\nGenerasi Muda",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Dengan menjadi mentor, Anda memberikan ilmu inspiratif, mengembangkan potensi mentee, dan bersama membangun masa depan cerah.',
                              style: FontFamily().regularText,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Handoff/ilustrator/banner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  thickness:
                      1.0, // Atur ketebalan garis sesuai keinginan Anda, misalnya 1.0
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "what's the mentor activity",
                  style: FontFamily().regularText.copyWith(
                        fontSize: 16,
                        color: ColorStyle().primaryColors,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorStyle().tertiaryColors,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Handoff/ilustrator/looking mentor.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              "Bangun Kelas yang Menginspirasi",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Temukan potensi dalam menciptakan kelas menginspirasi yang mengubah hidup. Bergabunglah dalam perjalanan belajar yang tak terlupakan',
                              style: FontFamily().regularText,
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SmallElevatedButton(
                              width: 150,
                              height: 38,
                              title: 'Buat Kelas',
                              style: FontFamily().buttonText,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PersetujuanPremiClassMentor(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorStyle().tertiaryColors,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Handoff/ilustrator/learn together 2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              "Berikan Pengalaman menarik melalui Session",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Raih Potensi Anda dalam Membuat Sesi yang Menginspirasi. Bergabunglah dalam Perjalanan Menciptakan Pengalaman Belajar yang Tak Terlupakan untuk Semua',
                              style: FontFamily().regularText,
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SmallElevatedButton(
                              width: 150,
                              height: 38,
                              title: 'Buat Session',
                              style: FontFamily().buttonText,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FormCreateSessionScreen(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
