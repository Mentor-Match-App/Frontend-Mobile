import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
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
    // Sort the evaluations based on whether they have feedback
    widget.evaluasi.sort((a, b) {
      bool hasFeedbackA = a.feedbacks != null && a.feedbacks!.isNotEmpty;
      bool hasFeedbackB = b.feedbacks != null && b.feedbacks!.isNotEmpty;
      return hasFeedbackA == hasFeedbackB
          ? 0
          : hasFeedbackA
              ? -1
              : 1;
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Evaluasi",
              style: FontFamily().titleText.copyWith(
                    color: ColorStyle().primaryColors,
                  ),
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => NotificationMenteeScreen(),
                //   ),
                // );
              },
              icon: Icon(
                Icons.notifications_none_outlined,
                color: ColorStyle().secondaryColors,
              ),
            ),
          ],
        ),
      ),
      body: widget.evaluasi.isEmpty
          ? Center(
              child: Text("Evaluation is currently empty",
                  style: FontFamily().regularText),
            )
          : ListView.builder(
              itemCount: widget.evaluasi.length,
              itemBuilder: (context, index) {
                var evaluation = widget.evaluasi[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, bottom: 24.0),
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 4.0,
                      left: 4.0,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        color: ColorStyle().tertiaryColors,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/Handoff/icon/MyClass/evaluasi_icon.png',
                              width: 80,
                              height: 80,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          evaluation.topic ?? 'Tidak ada topik',
                                          style: FontFamily().boldText.copyWith(
                                                fontSize: 16,
                                                color: ColorStyle()
                                                    .secondaryColors,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              evaluation.feedbacks != null &&
                                                      evaluation
                                                          .feedbacks!.isNotEmpty
                                                  ? evaluation.feedbacks!
                                                      .map((feedback) => Text(
                                                            "result : ${feedback.result}",
                                                            style: FontFamily()
                                                                .boldText
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  color: ColorStyle()
                                                                      .secondaryColors,
                                                                ),
                                                          ))
                                                      .toList()
                                                  : [
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
                                                    ],
                                        ),
                                      ),
                                    ],
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
                                                          CrossAxisAlignment
                                                              .start,
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
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                          'Feedback evaluasi: \n${feedback.content}',
                                                          style: FontFamily()
                                                              .regularText,
                                                        ),
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
                                                            .secondaryColors,
                                                      ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Belum ada feedback',
                                                  style:
                                                      FontFamily().regularText,
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
                                      backgroundColor:
                                          ColorStyle().disableColors,
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
                                      backgroundColor:
                                          ColorStyle().primaryColors,
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
