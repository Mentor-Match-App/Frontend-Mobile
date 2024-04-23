import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/myClass_mentor_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class ListEvaluasiMentee extends StatefulWidget {
  final String nameMentee;
  final String currentMenteeId;
  final List<Evaluation> evaluations;
  final String classId;
  ListEvaluasiMentee({
    Key? key,
    required this.evaluations,
    required this.nameMentee,
    required this.classId,
    required this.currentMenteeId,
  }) : super(key: key);

  @override
  State<ListEvaluasiMentee> createState() => _ListEvaluasiMenteeState();
}

class _ListEvaluasiMenteeState extends State<ListEvaluasiMentee> {
  List<String> listMateriEvaluasi = [];
  @override
  void initState() {
    super.initState();
    listMateriEvaluasi = widget.evaluations.map((e) => e.topic ?? "").toList();
    print(widget.evaluations);
  }

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
        title: Text(
          widget.nameMentee,
          style: FontFamily()
              .boldText
              .copyWith(fontSize: 16, color: ColorStyle().primaryColors),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.evaluations.length,
        itemBuilder: (context, index) {
          // Mendapatkan evaluasi terbaru
          var evaluation = widget.evaluations[index];

          // Mendapatkan feedbacks untuk currentMenteeId
          var feedbacksForCurrentMentee = evaluation.feedbacks
                  ?.where(
                      (feedback) => feedback.menteeId == widget.currentMenteeId)
                  .toList() ??
              [];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context)
                    .size
                    .width, // Membatasi lebar maksimum Container
              ),
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border:
                    Border.all(color: ColorStyle().tertiaryColors, width: 2),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/Handoff/icon/MyClass/evaluasi_icon.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Materi ${index + 1}",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 16,
                                          color: ColorStyle().secondaryColors,
                                        ),
                                  ),
                                ),
                                // Periksa apakah evaluation.feedbacks tidak null dan index valid
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: feedbacksForCurrentMentee.isEmpty
                                        ? [
                                            Text(
                                              "Nilai :-",
                                              style: FontFamily()
                                                  .boldText
                                                  .copyWith(
                                                    fontSize: 16,
                                                    color: ColorStyle()
                                                        .secondaryColors,
                                                  ),
                                            ),
                                          ]
                                        : feedbacksForCurrentMentee
                                            .map((feedback) {
                                            return Text(
                                              "result : ${feedback.result}",
                                              style: FontFamily()
                                                  .boldText
                                                  .copyWith(
                                                    fontSize: 16,
                                                    color: ColorStyle()
                                                        .secondaryColors,
                                                  ),
                                            );
                                          }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Topik : ${evaluation.topic}",
                              style: FontFamily().regularText,
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
                                                  Text('${feedback.content}',
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
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    fontSize: 16,
                                                    color: ColorStyle()
                                                        .secondaryColors),
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
