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
      body: ListView.builder(
        itemCount: widget.evaluasi.length,
        itemBuilder: (context, index) {
          // Mendapatkan evaluasi saat ini
          var evaluation = widget.evaluasi[index];
          // Mendapatkan feedbacks untuk currentMenteeId

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border:
                    Border.all(color: ColorStyle().tertiaryColors, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/Handoff/icon/MyClass/evaluasi_icon.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //buat materi nya berurutan dari 1 dan akan bertambah 1
                          Row(
                            children: [
                              Text(
                                "Materi ${index + 1}",
                                style: FontFamily().boldText.copyWith(
                                    fontSize: 16,
                                    color: ColorStyle().secondaryColors),
                              ),
                              const SizedBox(width: 180),
                              // Periksa apakah evaluation.feedbacks tidak null dan index valid
                              evaluation.feedbacks != null &&
                                      index < evaluation.feedbacks!.length
                                  ? Text(
                                      "Nilai : ${evaluation.feedbacks![index].result}",
                                      style: FontFamily().boldText.copyWith(
                                          fontSize: 16,
                                          color: ColorStyle().secondaryColors),
                                    )
                                  : Text(
                                      "Nilai : -", // Tampilkan "-" jika kondisi tidak terpenuhi
                                      style: FontFamily().boldText.copyWith(
                                          fontSize: 16,
                                          color: ColorStyle().secondaryColors),
                                    ),
                            ],
                          ),

                          const SizedBox(height: 8),
                          Text(
                            evaluation.topic ?? 'Tidak ada topik',
                            style:
                                FontFamily().regularText.copyWith(fontSize: 14),
                          ),

                          const SizedBox(height: 4),
                          ...(evaluation.feedbacks != null &&
                                  evaluation.feedbacks!.isNotEmpty)
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: evaluation.feedbacks!
                                          .map(
                                            (feedback) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Feedback :",
                                                  style: FontFamily()
                                                      .boldText
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color: ColorStyle()
                                                              .secondaryColors),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                    'Feedback evaluasi: \n${feedback.content}',
                                                    style: FontFamily()
                                                        .regularText),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ]
                              : [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Feedback :",
                                          style: FontFamily().boldText.copyWith(
                                              fontSize: 16,
                                              color:
                                                  ColorStyle().secondaryColors),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Belum ada feedback',
                                          style: FontFamily().regularText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: evaluation.feedbacks != null &&
                            evaluation.feedbacks!.isNotEmpty
                        ? SizedBox(
                            height: 40,
                            width: 160,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: ColorStyle().disableColors,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              onPressed: null, // Dinonaktifkan
                              child: Text(
                                'Selesai',
                                style: FontFamily().buttonText.copyWith(
                                      fontSize: 12,
                                      color: ColorStyle().whiteColors,
                                    ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 40,
                            width: 160,
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: ColorStyle().primaryColors,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              onPressed: () =>
                                  _launchURL(evaluation.link ?? ''),
                              icon: Icon(Icons.link,
                                  color: ColorStyle().whiteColors),
                              label: Text(
                                'Buka Evaluasi',
                                style: FontFamily().buttonText.copyWith(
                                      fontSize: 12,
                                      color: ColorStyle().whiteColors,
                                    ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
