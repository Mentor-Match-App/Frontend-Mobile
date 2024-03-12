import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syaratketentuan_daftar_mentor/persetujuan_module_pembelajaran.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syaratketentuan_daftar_mentor/persetujuan_rekening.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/category_card.dart';

class PersetujuanPremiClassMentor extends StatefulWidget {
  PersetujuanPremiClassMentor({Key? key}) : super(key: key);

  @override
  State<PersetujuanPremiClassMentor> createState() =>
      _PersetujuanPremiClassMentorState();
}

class _PersetujuanPremiClassMentorState
    extends State<PersetujuanPremiClassMentor> {
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
                        'Mentor wajib berkomitmen untuk membuat kelas dengan kualitas yang tinggi dan memenuhi janji waktu yang telah ditetapkan.',
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
                        'Mentor harus memiliki materi dan topik yang relevan, bermanfaat, dan menarik bagi peserta kelas.',
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
                        'Mentor berhak menetapkan harga kelas sesuai dengan standar dan nilai dari materi yang diajarkan.',
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
                        'Mentor akan menerima 70% dari harga yang telah ditetapkan sebagai gaji, yang akan ditransfer ke rekening bank yang telah didaftarkan.',
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
                        'Apabila mentor tidak memenuhi kewajibannya atau tidak bertanggung jawab, maka gaji atau pembayaran tidak akan diberikan.',
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
                        'Mentor yang tidak bertanggung jawab akan di-blacklist dan tidak diizinkan untuk mengajar di platform kami untuk periode waktu yang tidak ditentukan.',
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
                                        PersetujuanModulePremiClassMentor()));
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
