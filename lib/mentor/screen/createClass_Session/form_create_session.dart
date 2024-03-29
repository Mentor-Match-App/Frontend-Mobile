import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/provider/create_session_provider.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/succes_create_session.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:mentormatch_apps/widget/textField_dropdown.dart';
import 'package:mentormatch_apps/widget/timePicker_widget.dart';
import 'package:provider/provider.dart';

class FormCreateSessionScreen extends StatefulWidget {
  FormCreateSessionScreen({Key? key}) : super(key: key);

  @override
  State<FormCreateSessionScreen> createState() =>
      _FormCreateSessionScreenState();
}

class _FormCreateSessionScreenState extends State<FormCreateSessionScreen> {
  TextEditingController topicController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

///////////dropdown/////
  List<String> selectedFields = [
    "Back End",
    "Data Analyst",
    "Finance",
    "Marketing",
    "Quality Assurance",
    "Security Engineer",
    "Desain",
    "Front End",
  ];

  @override
  void dispose() {
    categoryController.dispose();
    topicController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    capacityController.dispose();
    descriptionController.dispose();
    endTimeController.dispose();

    super.dispose();
  }

  void submitSession() async {
    DateTime? date;
    try {
      date = DateFormat('yyyy-MM-dd').parse(dateController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Format tanggal tidak valid')));
      return;
    }

    DateTime startTime = DateTime(date.year, date.month, date.day);
    DateTime endTime = DateTime(date.year, date.month, date.day);

    try {
      final startTimeStr = startTimeController.text.split(':');
      final endTimeStr = endTimeController.text.split(':');
      startTime = DateTime(date.year, date.month, date.day,
          int.parse(startTimeStr[0]), int.parse(startTimeStr[1]));
      endTime = DateTime(date.year, date.month, date.day,
          int.parse(endTimeStr[0]), int.parse(endTimeStr[1]));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Format waktu tidak valid')));
      return;
    }

    bool success =
        await Provider.of<CreateSessionProvider>(context, listen: false)
            .submitSession(
      category: categoryController
          .text, // Pastikan ini adalah nilai kategori yang benar, bukan deskripsi
      date: date,
      startTime: startTime, // Langsung berikan objek DateTime startTime
      endTime: endTime, // Langsung berikan objek DateTime endTime
      maxParticipants: int.tryParse(capacityController.text) ?? 0,
      description: descriptionController.text,
      title: topicController.text,
    );
    if (!mounted) return; // Cek apakah widget masih terpasang
    if (success) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => SuccesCreateSessionScreen(),
          ),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal membuat sesi')));
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Session",
          style: FontFamily().regularText.copyWith(
                fontSize: 20,
                color: ColorStyle().primaryColors,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buat Pengalaman Mentorship Anda",
                        style: FontFamily().boldText.copyWith(
                              fontSize: 24,
                              color: ColorStyle().secondaryColors,
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Buat Sesi Anda Sendiri dan jelajahi peluang untuk membimbing dan mendukung orang lain dalam mencapai tujuan mereka. Jadilah sumber inspirasi bagi mereka yang mencari bimbingan dan arahan',
                        style: FontFamily().regularText,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Topic Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                TextFieldWidget(
                  controller: topicController,
                  hintText: "input your topic session",
                  validator: (value) {
                    // Periksa apakah field kosong
                    if (value == null || value.isEmpty) {
                      return 'Field ini tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                TittleTextField(
                  title: "Category Session",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MyDropdownWidgetSession(
                    items: selectedFields,
                    selectedValue: categoryController.text.isNotEmpty
                        ? categoryController.text
                        : null,
                    onChanged: (value) {
                      setState(() {
                        categoryController.text = value ?? '';
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Description Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                TextFieldWidgetBig(
                  descriptionController: descriptionController,
                  title: "input your description session",
                  validator: (value) {
                    // Periksa apakah field kosong
                    if (value == null || value.isEmpty) {
                      return 'Field ini tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Tanggal Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                DatePickerWidget(
                  controller: dateController,
                  onDateSelected: (date) {
                    dateController.text = date.toIso8601String();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "Jadwal Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                Row(
                  children: [
                    TimePickerWidget(
                        title: "Start Time",
                        onTimeSelected: (time) {
                          startTimeController.text = time.format(context);
                        },
                        controller: startTimeController),
                    TimePickerWidget(
                        title: "End Time",
                        onTimeSelected: (time) {
                          endTimeController.text = time.format(context);
                        },
                        controller: endTimeController),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TittleTextField(
                    title: "capacity Session",
                    color: ColorStyle().secondaryColors,
                  ),
                ),
                TextFieldWidget(
                  hintText: "input your capacity session",
                  controller: capacityController,
                  validator: validatorCapacity,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    submitSession();
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

  String? validatorCapacity(String? value) {
    // Pertama, periksa apakah value null atau tidak, karena parameter bertipe String?
    if (value == null || value.isEmpty) {
      return 'tidak boleh kosong';
    }
    // Gunakan ekspresi reguler untuk memeriksa apakah value hanya berisi angka
    final isDigitsOnly = RegExp(r'^\d+$').hasMatch(value);
    if (!isDigitsOnly) {
      return ' hanya boleh berisi angka';
    }
    return null;
  }
}
