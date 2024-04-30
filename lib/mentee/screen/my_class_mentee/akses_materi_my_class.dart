import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterMyClass extends StatefulWidget {
  final List<LearningMaterialMyClass> learningMaterial;
  MaterMyClass({Key? key, required this.learningMaterial}) : super(key: key);

  @override
  State<MaterMyClass> createState() => _MaterMyClassState();
}

class _MaterMyClassState extends State<MaterMyClass> {
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
              "Materi Pembelajaran",
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Kamu dapat mengakses materi yang telah disediakan oleh mentor disini. Silahkan klik pada materi yang ingin kamu akses untuk memulai belajar materi tersebut ya!',
                    style: FontFamily().regularText,
                  ),
                  Column(
                    children: List.generate(
                      widget.learningMaterial
                          .length, // Ganti dengan jumlah targetLearning
                      (materialIndex) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TittleTextField(
                            title:
                                // Menambahkan nomor pada judul Topik berdasrkan index
                                "Materi ke ${materialIndex + 1}",
                          ),
                          ElevatedButtonWidget(
                            onPressed: () {
                              final linkEvaluasi =
                                  widget.learningMaterial[materialIndex].link ??
                                      '';
                              _launchURL(linkEvaluasi);
                            },
                            title:
                                widget.learningMaterial[materialIndex].title ??
                                    '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
