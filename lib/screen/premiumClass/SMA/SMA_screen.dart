import 'package:flutter/material.dart';
import 'package:mentormatch_apps/screen/login-register/first_screen.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';
import 'package:mentormatch_apps/widget/menu_category.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class SMAScreen extends StatefulWidget {
  SMAScreen({Key? key}) : super(key: key);

  @override
  State<SMAScreen> createState() => _SMAScreenState();
}

class _SMAScreenState extends State<SMAScreen> {
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
                )
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
      'assets/Handoff/icon/categoryIcon/SMA/all.png',
      'assets/Handoff/icon/categoryIcon/SMA/bilogy.png',
      'assets/Handoff/icon/categoryIcon/SMA/economi.png',
      'assets/Handoff/icon/categoryIcon/SMA/fisika.png',
      'assets/Handoff/icon/categoryIcon/SMA/geografi.png',
      'assets/Handoff/icon/categoryIcon/SMA/kimia.png',
      'assets/Handoff/icon/categoryIcon/SMA/math.png',
      'assets/Handoff/icon/categoryIcon/SMA/Sastra Bahasa.png',
      'assets/Handoff/icon/categoryIcon/SMA/tech.png',
    ];

    // Pastikan indeks berada dalam rentang yang benar
    if (index >= 0 && index < imagePaths.length) {
      return imagePaths[index];
    } else {
      // Atur fallback atau logika tambahan jika indeks di luar rentang yang diinginkan
      return 'assets/Handoff/icon/categoryIcon/SMA/all.png'; // Contoh fallback
    }
  }

  List<String> categoryList = [
    "All",
    "Biology",
    "Ekonomi",
    "Fisika",
    "Geograpi",
    "Kimia",
    "Matematika",
    "Sastra Bahasa",
    "Teknologi",

    // Tambahkan kategori lainnya sesuai kebutuhan
  ];
}
