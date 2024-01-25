import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/Detail_myClass_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class MyClassMenteeListScreen extends StatefulWidget {
  MyClassMenteeListScreen({Key? key}) : super(key: key);

  @override
  State<MyClassMenteeListScreen> createState() => _MyClassMenteeListScreenState();
}

class MyClass {
  final String title;
  final String duration;
  final String mentor;

  MyClass({required this.title, required this.duration, required this.mentor});
}

class MySession {
  final String title;
  final String time;
  final String mentor;

  MySession({required this.title, required this.time, required this.mentor});
}

class _MyClassMenteeListScreenState extends State<MyClassMenteeListScreen> {
  int currentIndex = 0;
  List<MyClass> myClasses = [
    MyClass(
      title: 'UI/UX Design & Research',
      duration: '3 Bulan',
      mentor: 'Charline June',
    ),
    // Tambahkan item kelas lainnya sesuai kebutuhan
  ];
  List<MySession> mySession = [
    MySession(
      title: 'Mastering Modern Web Development with Node.js and React',
      time: '28 Februari 2021 (19.00 WIB)',
      mentor: 'Charline June',
    ),
    // Tambahkan item kelas lainnya sesuai kebutuhan
  ];

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentIndex = 0; // Indeks untuk My Class
                    });
                  },
                  icon: Icon(
                    Icons.menu_book_outlined,
                    color: currentIndex == 0
                        ? ColorStyle().primaryColors
                        : Colors.black, // Ganti warna sesuai kondisi
                  ),
                  label: Text(
                    "My Class",
                    style: FontFamily().boldText.copyWith(
                          color: currentIndex == 0
                              ? ColorStyle().primaryColors
                              : Colors.black, // Ganti warna sesuai kondisi
                        ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      currentIndex = 1; // Indeks untuk My Session
                    });
                  },
                  icon: Icon(
                    Icons.volume_down_alt,
                    color: currentIndex == 1
                        ? ColorStyle().primaryColors
                        : Colors.black, // Ganti warna sesuai kondisi
                  ),
                  label: Text(
                    "My Session",
                    style: FontFamily().boldText.copyWith(
                          color: currentIndex == 1
                              ? ColorStyle().primaryColors
                              : Colors.black, // Ganti warna sesuai kondisi
                        ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: ColorStyle().disableColors,
          ),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                buildMyClassContent(),
                buildMySessionContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMyClassContent() {
    return ListView.builder(
      itemCount: myClasses.length,
      itemBuilder: (context, index) {
        MyClass currentClass = myClasses[index];
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle().tertiaryColors,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.asset(
                      fit: BoxFit.cover,
                      "assets/Handoff/Ilustrator/profile.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentClass.title,
                          style: FontFamily().boldText,
                        ),
                        SizedBox(height: 12),
                        Text(
                          currentClass.duration,
                          style: FontFamily().regularText,
                        ),
                        Text(
                          'Mentor : ${currentClass.mentor}',
                          style: FontFamily().regularText,
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SmallElevatedButton(
                            height: 32,
                            width: 120,
                            title: "Lihat Kelas",
                            style: FontFamily().buttonText.copyWith(
                                  fontSize: 12,
                                  color: ColorStyle().whiteColors,
                                ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailMyClassMenteeScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMySessionContent() {
    // Konten untuk My Session, sesuaikan sesuai kebutuhan
    return ListView.builder(
      itemCount: mySession.length,
      itemBuilder: (context, index) {
        MySession currentSession = mySession[index];
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle().tertiaryColors,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          fit: BoxFit.cover,
                          "assets/Handoff/Ilustrator/profile.png",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentSession.title,
                              style: FontFamily().boldText,
                            ),
                            SizedBox(height: 12),
                            Text(
                              currentSession.time,
                              style: FontFamily().regularText,
                            ),
                            Text(
                              'Mentor : ${currentSession.mentor}',
                              style: FontFamily().regularText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'htttps/inilinkmentorigyangakankamuakses',
                          style: FontFamily().boldText,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      IconButton(
                        onPressed: () {
                          // Menyalin teks ke clipboard
                          Clipboard.setData(const ClipboardData(
                              text: 'htttps/inilinkmentorigyangakankamuakses'));

                          // Tampilkan snackbar atau pesan bahwa teks telah disalin
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 2),
                              backgroundColor: ColorStyle().tertiaryColors,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Link disalin',
                                style: FontFamily().regularText,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
