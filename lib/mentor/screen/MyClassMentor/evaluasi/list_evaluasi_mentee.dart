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
          // Mendapatkan evaluasi saat ini
          var evaluation = widget.evaluations[index];
          // Mendapatkan feedbacks untuk currentMenteeId
          var feedbacksForCurrentMentee = evaluation.feedbacks
                  ?.where(
                      (feedback) => feedback.menteeId == widget.currentMenteeId)
                  .toList() ??
              [];
          if (feedbacksForCurrentMentee.isEmpty)
            return SizedBox
                .shrink(); // Jika tidak ada feedback, tidak menampilkan apa-apa untuk evaluasi ini.

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
                  Text("Evaluasi :",
                      style: FontFamily().boldText.copyWith(
                          fontSize: 16, color: ColorStyle().secondaryColors)),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorStyle().primaryColors,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    onPressed: () => _launchURL(evaluation.link ?? ''),
                    icon: Icon(Icons.link, color: ColorStyle().whiteColors),
                    label: Text(
                      evaluation.topic ?? 'Tidak ada topik',
                      style: FontFamily().buttonText.copyWith(
                          fontSize: 12, color: ColorStyle().whiteColors),
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...feedbacksForCurrentMentee
                      .map((feedback) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Feedback evaluasi: \n${feedback.content}',
                                style: FontFamily().regularText),
                          ))
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
