import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_class.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_session.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syaratketentuan_daftar_mentor/persetujuan_premium_class_mentor.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/category_card.dart';

class HomeMentorScreen extends StatefulWidget {
  const HomeMentorScreen({Key? key}) : super(key: key);

  @override
  State<HomeMentorScreen> createState() => _HomeMentorScreenState();
}

class _HomeMentorScreenState extends State<HomeMentorScreen> {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              "Tingkatkan Masa Depan Generasi Muda",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Dengan menjadi mentor, Anda memberikan ilmu inspiratif, mengembangkan potensi mentee, dan bersama membangun masa depan cerah.',
                              style: FontFamily().regularText,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Handoff/ilustrator/mentor in zoom.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Field and Interest",
                  style: FontFamily().boldText.copyWith(
                        fontSize: 14,
                        color: ColorStyle().secondaryColors,
                      ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InterestCardMentor(
                          title: 'Technology',
                          icon: 'assets/Handoff/icon/categoryIcon/SD/tech.png'),
                      InterestCardMentor(
                          title: 'Engineering',
                          icon:
                              'assets/Handoff/icon/categoryIcon/Kuliah/electro.png'),
                      InterestCardMentor(
                          title: 'Sains',
                          icon:
                              'assets/Handoff/icon/categoryIcon/SD/Pengetahuan.jpg'),
                      InterestCardMentor(
                          title: 'Business',
                          icon:
                              'assets/Handoff/icon/categoryIcon/Karier/finance.png'),
                      InterestCardMentor(
                          title: 'Math',
                          icon: 'assets/Handoff/icon/categoryIcon/SD/math.png'),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SmallElevatedButton(
                              width: 150,
                              height: 38,
                              title: 'Buat Kelas',
                              style:  FontFamily().buttonText,
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
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Handoff/ilustrator/looking mentor.png'),
                            fit: BoxFit.cover,
                          ),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SmallElevatedButton(
                              width: 150,
                              height: 38,
                              title: 'Buat session',
                              style:  FontFamily().buttonText,
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
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Handoff/ilustrator/learn together 2.png'),
                            fit: BoxFit.cover,
                          ),
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
