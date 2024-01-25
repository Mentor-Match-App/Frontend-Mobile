import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/review_mentor_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class EvaluasiMenteeScreen extends StatefulWidget {
  EvaluasiMenteeScreen({Key? key}) : super(key: key);

  @override
  State<EvaluasiMenteeScreen> createState() => _EvaluasiMenteeScreenState();
}

class _EvaluasiMenteeScreenState extends State<EvaluasiMenteeScreen> {
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
                          "Panduan Evaluasi",
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
                                text:
                                    'Evaluasi  dilakukan setiap satu topik dalam program dan layanan sebagai penilaian atau pemeriksaan sistematis untuk mengevaluasi efektivitas, efisiensi, dan dampak dari suatu topik yang telah di ajarkan dalam program atau layanan. \n',
                              ),
                              TextSpan(
                                text: '2. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Tujuan evaluasi ini adalah untuk mengukur sejauh mana mentee dalam pencapain pembelajaran, mengidentifikasi area perbaikan, dan memberikan umpan balik yang dapat digunakan untuk meningkatkan kualitas dan efisiensi pelaksanaan program atau layanan tersebut.\n',
                              ),
                              TextSpan(
                                text: '3. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Evaluasi akan di berikan oleh mentor yang membimbingan kelas dalam bentu form yang akan di kirim pada saat kegiatan menting berlangsung ( zoom meeting)\n',
                              ),
                              TextSpan(
                                text: '4. ',
                                style: FontFamily().regularText,
                              ),
                              TextSpan(
                                style: FontFamily().regularText,
                                text:
                                    'Hasil dari evaluasi akan dikirim mentor pada halaman ini apabila mentee telah mengejakan dan mentor telah menilai dari jawaban yang mentee berikan.\n',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Link Evaluasi",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButtonWidget(
                    onPressed: () {},
                    title: " Evaluasi User Understanding",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButtonWidget(
                    onPressed: () {},
                    title: " Prinsip-prinsip desain aksesibilitas",
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.link,
                              color: ColorStyle().secondaryColors,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Evaluasi yang telah di kerjakan",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().primaryColors,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          "Materi Evaluasi : User Understanding",
                          style: FontFamily().boldText,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ColorStyle().blackColors, // Warna border
                                width: 2.0, // Lebar border
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Selamat atas penyelesaian Chapter 1, [Nama Mentee]! Pemahaman konsepnya sudah baik, dan analisisnya mendalam. Tetapi, tambahkan contoh atau aplikasi praktis untuk pemahaman yang lebih baik. Pastikan selalu mencantumkan sumber dan variasikan gaya penulisan. Untuk Chapter 2, fokus pada [area/topik spesifik] untuk memperdalam pemahaman. Jika ada pertanyaan, jangan ragu untuk bertanya. Bagus sekali, [Nama Mentee]! Saya yakin dengan ketekunan Anda, Anda akan berhasil di bab-bab berikutnya. Terima kasih."),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
