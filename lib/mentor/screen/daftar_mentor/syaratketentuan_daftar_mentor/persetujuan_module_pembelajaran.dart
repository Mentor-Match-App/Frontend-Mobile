import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syaratketentuan_daftar_mentor/persetujuan_rekening.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syaratketentuan_daftar_mentor/persetujuan_tahapan_premium_class_mentor.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';

class PersetujuanModulePremiClassMentor extends StatefulWidget {
  PersetujuanModulePremiClassMentor({Key? key}) : super(key: key);

  @override
  State<PersetujuanModulePremiClassMentor> createState() =>
      _PersetujuanModulePremiClassMentorState();
}

class _PersetujuanModulePremiClassMentorState
    extends State<PersetujuanModulePremiClassMentor> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Persetujuan Premium Class',
          style: FontFamily().titleText.copyWith(
                color: ColorStyle().primaryColors,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohon periksa dan baca terlebih dahulu syarat & ketentuan yang berlaku untuk menjadi mentor pada aplikasi MentorMatch ',
                  style: FontFamily().regularText,
                ),
                const SizedBox(
                  height: 8,
                ),
                const TittleTextField(
                  title: 'Syarat & Ketentuan',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('\u2022'),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Setiap premium class harus memiliki materi atau bab-bab yang disusun oleh mentor.',
                        style: FontFamily().regularText,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('\u2022'),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Bab-bab ini dapat terdiri dari topik-topik yang relevan dan berkaitan dengan tujuan pembelajaran kelas.',
                        style: FontFamily().regularText,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('\u2022'),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Setiap bab atau chapter yang dibuat oleh mentor harus memiliki modul yang dapat diakses oleh mentee.',
                        style: FontFamily().regularText,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('\u2022'),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Modul ini dapat berupa dokumen, presentasi, video, atau sumber belajar lainnya yang mendukung pemahaman materi.',
                        style: FontFamily().regularText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                      icon: Icon(
                        _isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: ColorStyle().succesColors,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Saya dengan ini menyatakan bahwa saya telah menyetujui sepenuhnya syarat dan ketentuan',
                        style: FontFamily().regularText.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _isSelected
                        ? () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PersetujuanTahapanPremiumClassMentor()));
                          }
                        : null, // Tidak mengizinkan klik jika radio button belum dicentang

                    child: Text(
                      'Lanjutkan',
                      style: FontFamily().boldText.copyWith(
                            color: _isSelected
                                ? ColorStyle().primaryColors
                                : ColorStyle().disableColors,
                            fontSize: 16,
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
