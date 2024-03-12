import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/myClass_model.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';

import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class EvaluasiMenteeScreen extends StatefulWidget {
  final List<EvaluationMyClass> evaluasi;

  EvaluasiMenteeScreen({Key? key, required this.evaluasi}) : super(key: key);

  @override
  State<EvaluasiMenteeScreen> createState() => _EvaluasiMenteeScreenState();
}

class _EvaluasiMenteeScreenState extends State<EvaluasiMenteeScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Evaluasi",
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
                Text(
                  "Panduan Evaluasi",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                const SizedBox(height: 24),
                Text(
                  "Evaluasi",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.evaluasi.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButtonWidget(
                              onPressed: () {
                                final linkEvaluasi =
                                    widget.evaluasi[index].link ?? '';
                                _launchURL(linkEvaluasi);
                              },
                              title: widget.evaluasi[index].topic,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "FeedBack Evaluasi",
                              style: FontFamily().regularText.copyWith(
                                  color: ColorStyle().secondaryColors),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ColorStyle().tertiaryColors,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.evaluasi[index].feedback ??
                                      "Belum ada feedback",
                                  style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().primaryColors),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
