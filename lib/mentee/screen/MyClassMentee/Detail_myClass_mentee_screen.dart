import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/evalusi_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/review_mentor_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class DetailMyClassMenteeScreen extends StatefulWidget {
  DetailMyClassMenteeScreen({Key? key}) : super(key: key);

  @override
  State<DetailMyClassMenteeScreen> createState() => _DetailMyClassMenteeScreenState();
}

class _DetailMyClassMenteeScreenState extends State<DetailMyClassMenteeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rincian Kegiatan",
            style: FontFamily()
                .titleText
                .copyWith(color: ColorStyle().primaryColors),
          ),
          IconButton(
         onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationMenteeScreen(),
                  ),
                );
              },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ColorStyle().secondaryColors,
            ),
          ),
        ],
      )),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Periode Program",
                          style: FontFamily().boldText.copyWith(
                              color: ColorStyle().primaryColors, fontSize: 16),
                        ),
                        Text(
                          "3 Bulan",
                          style: FontFamily().regularText,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Mentor",
                          style: FontFamily().boldText.copyWith(
                              color: ColorStyle().primaryColors, fontSize: 16),
                        ),
                        Text(
                          "Steven Jobs",
                          style: FontFamily().regularText,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "UI/UX Design Research & Design",
                          style: FontFamily().boldText.copyWith(
                              color: ColorStyle().primaryColors, fontSize: 16),
                        ),
                        Text(
                          'Kelas UI/UX Research & Design ini akan berjalan selama 3 bulan sesuai dengan syarat & ketentuan yang berlaku. Modul pembelajaran akan diterima setiap meeting zoom berlangsung. Mentee akan mendapatkan modul pembelajaran yang dikirim langsung oleh mentor. Mentee dapat melakukan mentoring secara online dan offline  sesuai dengan syarat & ketentuan yang berlaku. Pada setiap topik atau materi mentee akan mengerjakan evaluasi yang akan di review oleh mentor pada aplikasi MentirMatch.',
                          style: FontFamily().regularText,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Syrarat & Ketentuan",
                          style: FontFamily().boldText.copyWith(
                              color: ColorStyle().primaryColors, fontSize: 16),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '1. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text: 'Mahasiswa semester 1-7\n',
                              ),
                              TextSpan(
                                text: '2. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Mempunyai Komitmen untuk belajar secara serius\n',
                              ),
                              TextSpan(
                                text: '3. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Kelas berlangsung selama 4 kali dalam seminggu\n',
                              ),
                              TextSpan(
                                text: '4. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Dapat melakukan mentoring secara offline apabila jarak rumah dekat\n',
                              ),
                              TextSpan(
                                text: '5. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Wajib melakukan evaluasi setelah menyelesaikan 1 materi dan seterusnya sampai selesai\n',
                              ),
                              TextSpan(
                                text: '6. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                text:
                                    'Mentee akan mendapat modul pembelajaran dari mentor ketika zoom meeting\n',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                text: '7. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Memiliki Laptop dengan spesifikasi minimal (Prosesor i3/i5, Storage tersisa 160Gb, RAM Minimum 8Gb)\n',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Akses Link Zoom",
                          style: FontFamily().boldText.copyWith(
                              color: ColorStyle().primaryColors, fontSize: 16),
                        ),
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
                                    text:
                                        'htttps/inilinkmentorigyangakankamuakses'));

                                // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 2),
                                    backgroundColor:
                                        ColorStyle().tertiaryColors,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Teks telah disalin',
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
                const SizedBox(height: 24),
                ElevatedButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EvaluasiMenteeScreen(),
                      ),
                    );
                  },
                  title: "Evaluasi",
                ),
                const SizedBox(height: 24),
                ElevatedButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewMentorScreen(),
                      ),
                    );
                  },
                  title: "Review Mentor",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
