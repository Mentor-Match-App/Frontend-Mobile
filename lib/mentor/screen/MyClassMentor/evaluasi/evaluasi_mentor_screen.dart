import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/model/myClass_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/evaluasi/detail_evaluation_mentee_mentor.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class EvaluasiMentorScreen extends StatefulWidget {
  final List<Transaction> transactions;
  final List<Evaluation> evaluasi;
  final List<LearningMaterialMentor> learningMaterial;

  EvaluasiMentorScreen({
    Key? key,
    required this.learningMaterial,
    required this.evaluasi,
    required this.transactions,
  }) : super(key: key);

  @override
  State<EvaluasiMentorScreen> createState() => _EvaluasiMentorScreenState();
}

class _EvaluasiMentorScreenState extends State<EvaluasiMentorScreen> {
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
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
            "Evaluasi Mentee",
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
                const SizedBox(
                  height: 12,
                ),
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
                const SizedBox(height: 12),
                Text(
                  "List Mentee di Kelas Anda",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Column(
                  children: List.generate(
                    widget.transactions.length,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevetadButtonWithIcon(
                            title: widget.transactions[index].user!.name!,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailEvaluastionMenteeMentorScreen(
                                        learningMaterial: widget.learningMaterial,
                                    transactions: widget.transactions,
                                    classId: widget.transactions[index].classId
                                        .toString(),
                                    evaluations: widget.evaluasi,
                                    currentMenteeId: widget
                                        .transactions[index].userId
                                        .toString(),
                                    menteeName: widget
                                        .transactions[index].user!.name
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
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
