import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login-register/first_screen.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';
import 'package:mentormatch_apps/widget/menu_category.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class SDScreen extends StatefulWidget {
  SDScreen({Key? key}) : super(key: key);

  @override
  State<SDScreen> createState() => _SDScreenState();
}

class _SDScreenState extends State<SDScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(
                  title: 'Search by name,role,company',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 100, // Sesuaikan tinggi dengan kebutuhan Anda
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomCategoryWidget(
                          text: categoryList[index],
                          img: getCategoryImage(index),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FirstScreen(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    CardItemMentor(
                        imagePath: 'assets/Handoff/ilustrator/profile.png',
                        name: 'Charline June',
                        job: 'UI/UX Designer',
                        company: 'Google'),
                    CardItemMentor(
                        imagePath: 'assets/Handoff/ilustrator/profile.png',
                        name: 'Charline June',
                        job: 'UI/UX Designer',
                        company: 'Google'),
                  ],
                ),
                Row(
                  children: [
                    CardItemMentor(
                        imagePath: 'assets/Handoff/ilustrator/profile.png',
                        name: 'Charline June',
                        job: 'UI/UX Designer',
                        company: 'Google'),
                    CardItemMentor(
                        imagePath: 'assets/Handoff/ilustrator/profile.png',
                        name: 'Charline June',
                        job: 'UI/UX Designer',
                        company: 'Google'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getCategoryImage(int index) {
    // Ganti logika ini sesuai kebutuhan Anda
    List<String> imagePaths = [
      'assets/Handoff/icon/categoryIcon/SD/all.png',
      'assets/Handoff/icon/categoryIcon/SD/tech.png',
      'assets/Handoff/icon/categoryIcon/SD/pengetahuan.jpg',
      'assets/Handoff/icon/categoryIcon/SD/Sastra Bahasa.png',
      'assets/Handoff/icon/categoryIcon/SD/math.png',
    ];

    // Pastikan indeks berada dalam rentang yang benar
    if (index >= 0 && index < imagePaths.length) {
      return imagePaths[index];
    } else {
      // Atur fallback atau logika tambahan jika indeks di luar rentang yang diinginkan
      return 'assets/Handoff/icon/categoryIcon/SD/all.png'; // Contoh fallback
    }
  }

  List<String> categoryList = [
    "All",
    "Teknologi",
    "Matematika",
    "Pengetahuan",
    "Bahasa",
    // Tambahkan kategori lainnya sesuai kebutuhan
  ];
}
