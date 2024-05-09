import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/service/sent_materi_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/flushs_bar_widget.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMateriMentor extends StatefulWidget {
  final String classId;
  final List<LearningMaterialMentor> learningMaterial;
  const MyMateriMentor(
      {Key? key, required this.classId, required this.learningMaterial})
      : super(key: key);

  @override
  State<MyMateriMentor> createState() => _MyMateriMentorState();
}

class _MyMateriMentorState extends State<MyMateriMentor> {
  final TextEditingController _materiPembelajaranController =
      TextEditingController();
  final TextEditingController _linkMateriPembelajaranController =
      TextEditingController();
  bool _isLoading = false; // Menambahkan flag untuk loading state
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void dispose() {
    _materiPembelajaranController.dispose();
    _linkMateriPembelajaranController.dispose();

    super.dispose();
  }

  /// sent materi //
  // Fungsi untuk mengirim materi pembelajaran
  Future<void> _sendMaterial() async {
    String title = _materiPembelajaranController.text;
    String link = _linkMateriPembelajaranController.text;

    if (title.isEmpty || link.isEmpty) {
      // Tampilkan pesan error jika salah satu field kosong
      showTopSnackBar(context, "Field tidak boleh kosong",
          leftBarIndicatorColor: ColorStyle().errorColors);
      return;
    }

    // Mendapatkan classId dari konteks (Misalnya, dari Navigator arguments atau state lain)
    String classId =
        widget.classId; // Asumsikan classId didapatkan dari parameter widget

    setState(() {
      _isLoading = true; // Menandai bahwa request sedang diproses
    });

    try {
      LearningMaterialService service = LearningMaterialService();
      String responseMessage =
          await service.createLearningMaterial(classId, title, link);

      // Tampilkan pesan sukses jika response message sesuai
      if (responseMessage == "Learning material created successfully") {
        // ignore: use_build_context_synchronously
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().succesColors);
      } else {
        // Tampilkan pesan error jika response message tidak sesuai
        // ignore: use_build_context_synchronously
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().errorColors);
      }

      // Tambahkan materi yang baru saja dikirim ke daftar materi yang ditampilkan
      setState(() {
        widget.learningMaterial
            .add(LearningMaterialMentor(title: title, link: link));
      });

      // Bersihkan field setelah pengiriman berhasil
      _materiPembelajaranController.clear();
      _linkMateriPembelajaranController.clear();
    } catch (e) {
      // Tampilkan pesan error
      showTopSnackBar(context, e.toString(),
          leftBarIndicatorColor: ColorStyle().errorColors);
    } finally {
      setState(() {
        _isLoading = false; // Proses selesai, hilangkan indikator loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Materi Pembelajaran",
          style: FontFamily().boldText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 16,
              ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildFormSection(),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 3, //lebar
                mainAxisSpacing: 10, //tinggi
                mainAxisExtent: 180,
                maxCrossAxisExtent: 220),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildGridItem(index);
              },
              childCount: widget.learningMaterial.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    // Kode untuk membangun bagian form
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 12, right: 12, top: 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          border: Border.all(color: ColorStyle().tertiaryColors, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  "Kirim Materi Pembelajaran",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
              ),
              TittleTextField(
                title: "Materi Pembelajaran",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                controller: _materiPembelajaranController,
                hintText: "nama topik materi evaluasi",
              ),
              TittleTextField(
                title: "Link Evaluasi",
                color: ColorStyle().secondaryColors,
              ),
              TextFieldWidget(
                controller: _linkMateriPembelajaranController,
                hintText: "masukkan link evaluasi",
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: _isLoading
                    ? CircularProgressIndicator() // Tampilkan indikator loading jika sedang loading
                    : SmallElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                // Ketika tombol ditekan, atur _isLoading menjadi true
                                setState(() {
                                  _isLoading = true;
                                });
                                // Lakukan aksi yang diperlukan (contoh: _sendMaterial)
                                _sendMaterial().then((_) {
                                  // Ketika aksi selesai, atur _isLoading menjadi false
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
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
    );
  }

  Widget _buildGridItem(int materialIndex) {
    // Kode untuk membangun tiap item di grid
    final material = widget.learningMaterial[materialIndex];
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: ColorStyle().tertiaryColors,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              // spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/Handoff/icon/MyClass/materi_icon.png'),
              const SizedBox(
                height: 8,
              ),
              Text(widget.learningMaterial[materialIndex].title ?? '',
                  style: FontFamily().regularText),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ColorStyle().secondaryColors),
                ),
                onPressed: () {
                  final linkEvaluasi =
                      widget.learningMaterial[materialIndex].link ?? '';
                  _launchURL(linkEvaluasi);
                },
                child: Text(
                  'Download Materi',
                  style: FontFamily().buttonText.copyWith(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
