import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/evaluasi/send_feedback_detail_evaluasi.dart';
import 'package:mentormatch_apps/mentor/service/sent_evaluasi_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/flushs_bar_widget.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:url_launcher/url_launcher.dart';

class EvaluasiMentorScreen extends StatefulWidget {
  final List<FeedbackMyClassMentor> feedbacks;
  final String classId;
  final List<Transaction> transactions;
  final List<Evaluation> evaluasi;
  final List<LearningMaterialMentor> learningMaterial;

  EvaluasiMentorScreen({
    Key? key,
    required this.feedbacks,
    required this.classId,
    required this.learningMaterial,
    required this.evaluasi,
    required this.transactions,
  }) : super(key: key);

  @override
  State<EvaluasiMentorScreen> createState() => _EvaluasiMentorScreenState();
}

class _EvaluasiMentorScreenState extends State<EvaluasiMentorScreen> {
  String? selectedEvaluationId;
  String? selectedMateriEvaluasi;

  bool _isLoading = false;
  final TextEditingController _materiEvaluasiController =
      TextEditingController();
  final TextEditingController _linkEvaluasiController = TextEditingController();

  @override
  void dispose() {
    _materiEvaluasiController.dispose();
    _linkEvaluasiController.dispose();

    super.dispose();
  }

  void _sendEvaluation() async {
    String title = _materiEvaluasiController.text;
    String link = _linkEvaluasiController.text;
    if (title.isEmpty || link.isEmpty) {
      // Tampilkan pesan error jika salah satu field kosong
      showTopSnackBar(context, "Field tidak boleh kosong",
          leftBarIndicatorColor: ColorStyle().errorColors);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final service = SendEvaluasiService();
      String responseMessage = await service.sendEvaluationLink(
        widget.classId,
        _materiEvaluasiController.text,
        _linkEvaluasiController.text,
      );

      if (responseMessage.contains("berhasil")) {
        // Tampilkan snackbar dengan warna hijau untuk pesan sukses dari server
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().succesColors);
        // Bersihkan form setelah berhasil
        setState(() {
          widget.evaluasi.add(
            Evaluation(topic: title, link: link),
          );
        });
      } else {
        // Tampilkan snackbar dengan warna merah untuk pesan error dari server
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().errorColors);
      }
    } catch (e) {
      // Tangkap error yang terjadi pada sisi Flutter
      showTopSnackBar(context, "Terjadi kesalahan saat mengirim evaluasi",
          leftBarIndicatorColor: ColorStyle().errorColors);
    } finally {
      setState(() => _isLoading = false);
    }
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    border: Border.all(
                        color: ColorStyle().tertiaryColors, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(
                            "Kirim Evaluasi Mentee",
                            style: FontFamily().boldText.copyWith(
                                color: ColorStyle().primaryColors,
                                fontSize: 16),
                          ),
                        ),
                        TittleTextField(
                          title: "Materi Evaluasi",
                          color: ColorStyle().secondaryColors,
                        ),
                        // TextFieldWidget(
                        //   controller: _materiEvaluasiController,
                        //   hintText: "nama topik materi evaluasi",
                        // ),
                        DropdownButtonFormField<String>(
                          value: selectedMateriEvaluasi,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorStyle().tertiaryColors,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Pilih materi evaluasi',
                            hintStyle: FontFamily().regularText.copyWith(
                                  color: ColorStyle().disableColors,
                                ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMateriEvaluasi = newValue;
                              // Cari materi evaluasi yang sesuai dari list
                              final selectedMaterial =
                                  widget.learningMaterial.firstWhere(
                                (material) => material.title == newValue,
                                orElse: () =>
                                    LearningMaterialMentor(title: "", link: ""),
                              );
                              // Perbarui controller dengan title dari materi yang dipilih
                              _materiEvaluasiController.text =
                                  selectedMaterial.title ?? "";
                            });
                          },
                          items: widget.learningMaterial
                              .map((LearningMaterialMentor material) {
                            return DropdownMenuItem<String>(
                              value: material.title,
                              child: Text(material.title ?? ""),
                            );
                          }).toList(),
                          isExpanded: true,
                        ),

                        TittleTextField(
                          title: "Link Evaluasi",
                          color: ColorStyle().secondaryColors,
                        ),
                        TextFieldWidget(
                          controller: _linkEvaluasiController,
                          hintText: "masukkan link evaluasi",
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SmallElevatedButton(
                            onPressed: _sendEvaluation,
                            height: 40,
                            width: 118,
                            title: "Kirim",
                            style: FontFamily().buttonText.copyWith(
                                  fontSize: 12,
                                  color: ColorStyle().whiteColors,
                                ),
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
                                      
                                    feedbacks: widget.feedbacks,
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
