import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/home_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:mentormatch_apps/widget/textField_dropdown.dart';

class FormCreatePremiumClassScreen extends StatefulWidget {
  FormCreatePremiumClassScreen({Key? key}) : super(key: key);

  @override
  State<FormCreatePremiumClassScreen> createState() =>
      _FormCreatePremiumClassScreenState();
}

class _FormCreatePremiumClassScreenState
    extends State<FormCreatePremiumClassScreen> {
  String selectedEducationLevel = 'SD';
  List<String> selectedFields = ['bahasa', 'matematika', 'IPA', 'IPS'];
  String selectedField = ''; // New selected field
  Map<String, List<String>> fieldOptions = {
    'SD': ['bahasa', 'matematika', 'IPA', 'IPS'],
    'SMP': ['Matematika', 'jeremay', 'IPA', 'IPS'],
    'SMA': ['Kimia', 'Fisika', 'Biologi', 'Matematika'],
    'Kuliah': ['Mata Kuliah A', 'Mata Kuliah B', 'Mata Kuliah C'],
    'Karier': [
      'Bidang Pekerjaan A',
      'Bidang Pekerjaan B',
      'Bidang Pekerjaan C'
    ],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Premium Class"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TittleTextField(
                  title: "Tingkat Pendidikan",
                  color: ColorStyle().secondaryColors,
                ),
                MyDropdownWidget(
                  items: ['SD', 'SMP', 'SMA', 'Kuliah', 'Karier'],
                  onChanged: (value) {
                    setState(() {
                      selectedEducationLevel = value.toString();
                      selectedFields =
                          fieldOptions[selectedEducationLevel] ?? [];
                      selectedField =
                          ''; // Reset selectedField when education level changes
                    });
                  },
                ),
                // MyDropdownWidget(
                //     items: ['SD', 'SMP', 'SMA', 'Kuliah', 'Karier']),
                TittleTextField(
                  title: "Bidang & Minat",
                  color: ColorStyle().secondaryColors,
                ),
                // MyDropdownWidget(items: [
                //   'bahasa',
                //   'matematika',
                //   'IPA',
                //   'IPS',
                // ]),

                MyDropdownWidget(
                  items: selectedFields,
                  onChanged: (value) {
                    setState(() {
                      selectedField = value.toString();
                    });
                  },
                ),
                TittleTextField(
                  title: "Nama Kelas",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "input nama kelas",
                ),
                TittleTextField(
                  title: "Harga",
                  color: ColorStyle().secondaryColors,
                ),
                const TextFieldWidget(
                  hintText: "input harga",
                ),
                TittleTextField(
                  title: "Periode Kegiatan",
                  color: ColorStyle().secondaryColors,
                ),
                MyDropdownWidget(items: ['1 Bulan', '2 Bulan', '3 Bulan']),
                TittleTextField(
                  title: "Rincian Kegiatan",
                  color: ColorStyle().secondaryColors,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Tulis deskripsi kegiatan yang akan dilakukan",
                    hintStyle: FontFamily().regularText,
                  ),
                  maxLines: 5,
                ),
                TittleTextField(
                  title: "Syarat & Ketentuan",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Tulis deskripsi kegiatan yang akan dilakukan",
                      hintStyle: FontFamily().regularText,
                    ),
                    maxLines: 1,
                  ),
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeMentorScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  title: "Kirim",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
