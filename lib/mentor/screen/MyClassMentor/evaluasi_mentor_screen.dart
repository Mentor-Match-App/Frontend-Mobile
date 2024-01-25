import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/review_mentor_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';

class EvaluasiMentorScreen extends StatefulWidget {
  EvaluasiMentorScreen({Key? key}) : super(key: key);

  @override
  State<EvaluasiMentorScreen> createState() => _EvaluasiMentorScreenState();
}

class _EvaluasiMentorScreenState extends State<EvaluasiMentorScreen> {
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
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: Text(
                    "Link Evaluasi Mentee",
                    style: FontFamily().boldText.copyWith(
                        color: ColorStyle().primaryColors, fontSize: 16),
                  ),
                ),
                TittleTextField(
                  title: "Materi Evaluasi",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "nama topik materi evaluasi",
                ),
                TittleTextField(
                  title: "Link Evaluasi",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "masukkan link evaluasi",
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: SmallElevatedButton(
                    height: 40,
                    width: 118,
                    title: "Kirim",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().whiteColors,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: Text(
                    "Hasil Evaluasi Mentee",
                    style: FontFamily().boldText.copyWith(
                        color: ColorStyle().primaryColors, fontSize: 16),
                  ),
                ),
                TittleTextField(
                  title: "Materi Evaluasi",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "nama topik materi evaluasi",
                ),
                TittleTextField(
                  title: "Hasil Evaluasi",
                  color: ColorStyle().secondaryColors,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Masukan hasil dari evaluasi yang di kerjakan oleh mentee",
                    hintStyle: FontFamily().regularText.copyWith(
                      color: ColorStyle().disableColors
                    )
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: SmallElevatedButton(
                    height: 40,
                    width: 118,
                    title: "Kirim",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().whiteColors,
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
