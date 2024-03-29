import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/provider/create_class_provider.dart';
import 'package:mentormatch_apps/mentor/screen/create_Class_dan_Session/contoh_premium_class.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:mentormatch_apps/mentor/screen/create_Class_dan_Session/succes_create_class.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/textField.dart';
import 'package:mentormatch_apps/widget/textField_dropdown.dart';
import 'package:mentormatch_apps/widget/timePicker_widget.dart';
import 'package:provider/provider.dart';

class FormCreatePremiumClassScreen extends StatefulWidget {
  const FormCreatePremiumClassScreen({Key? key}) : super(key: key);

  @override
  State<FormCreatePremiumClassScreen> createState() =>
      _FormCreatePremiumClassScreenState();
}

class _FormCreatePremiumClassScreenState
    extends State<FormCreatePremiumClassScreen> {
  String selectedLocation = 'Offline';
  /////////////////////// Dropdown Widget ///////////////////////
  String selectedEducationLevel = 'SD';
  List<String> selectedFields = ['bahasa', 'matematika', 'IPA', 'IPS'];
  String selectedField = '';
  Map<String, List<String>> fieldOptions = {
    'SD': ["Matematika", "Bahasa", "Pengetahuan", "Teknologi"],
    'SMP': [
      "Matematika",
      "Bahasa",
      "Teknologi",
      "Biologi",
      "Ekonomi",
      "Fisika",
      "Geografi",
      "Kimia"
    ],
    'SMA': [
      "Matematika",
      "Bahasa",
      "Teknologi",
      "Biologi",
      "Ekonomi",
      "Fisika",
      "Geografi",
      "Kimia"
    ],
    'Kuliah': [
      "Computer Science",
      "Desain",
      "Teknik Elektro",
      "Ilmu Komunikasi",
      "Teknik Informasi",
      "Manajemen",
      "Psikologi",
      "Pendidikan Guru"
    ],
    'Karier': [
      "Back End",
      "Data Analyst",
      "Finance",
      "Marketing",
      "Quality Assurance",
      "Security Engineer",
      "Desain",
      "Front End",
    ],
  };

  List<String> days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu"
  ];
  List<String> selectedDays = [];

  /////////////// fuvtion sent ///////////////////
  TextEditingController scheduleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController maxParticipantsController = TextEditingController();
  TextEditingController educationLevelController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<TextEditingController> targetLearningController = [
    TextEditingController()
  ];
  List<TextEditingController> termsController = [TextEditingController()];
  TextEditingController durationInDaysController = TextEditingController();
  TextEditingController descriptionCobtroller = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  /// delete and add textfield ///
  void deleteTextField(List<TextEditingController> controllers, int index) {
    setState(() {
      // Pastikan untuk memanggil dispose pada controller yang akan dihapus
      controllers[index].dispose();
      // Kemudian hapus controller dari list
      controllers.removeAt(index);
    });
  }

  void addTextField(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

//// dispose controller ///
  @override
  void dispose() {
    for (var controller in targetLearningController) {
      controller.dispose();
    }
    // Dispose controllers when widget is removed from the widget tree
    nameController.dispose();
    priceController.dispose();
    durationInDaysController.dispose();
    descriptionCobtroller.dispose();
    for (var controller in termsController) {
      controller.dispose();
    }
    maxParticipantsController.dispose();
    super.dispose();
  }
///////////////// hari ///

  void showMultiSelect(BuildContext context) async {
    final List<String>? tempSelectedValues = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        // Asumsikan MultiSelectDialog adalah widget dialog yang Anda buat
        // yang memungkinkan pengguna memilih beberapa item
        return MultiSelectDialog(
          items: days.map((day) => MultiSelectItem(day, day)).toList(),
          initialValue: selectedDays,
          onConfirm: (values) {
            // Ini adalah callback yang dipanggil dengan nilai yang dipilih pengguna
          },
        );
      },
    );

    // Memberikan nilai default [] jika hasil dialog adalah null
    final List<String> selectedValues = tempSelectedValues ?? [];

    setState(() {
      selectedDays = selectedValues;
      scheduleController.text = selectedDays.join(', ');
    });
  }

//////////////////// onSubmit ///////////////////////
  void onSubmit() async {
    bool success =
        await Provider.of<CreateClassProvider>(context, listen: false)
            .submitClass(
      address: addressController.text,
      targetLearning: targetLearningController.map((e) => e.text).toList(),
      schedule: scheduleController.text,
      location: selectedLocation,
      endDate: DateTime.parse(endDateController.text),
      startDate: DateTime.parse(startDateController.text),
      capacitymentee: int.tryParse(maxParticipantsController.text) ?? 0,
      educationLevel: selectedEducationLevel,
      category: selectedField,
      name: nameController.text,
      description: descriptionCobtroller.text,
      terms: termsController.map((e) => e.text).toList(),
      price: int.tryParse(priceController.text) ?? 0,
      durationInDays: int.tryParse(durationInDaysController.text) ?? 0,
    );

    if (success) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SuccesCreateClassScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      String errorMessage =
          Provider.of<CreateClassProvider>(context, listen: false).errorMessage;
      // Tampilkan error message
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

//// count duration ///
  void calculateDuration() {
    if (startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateTime startDate = formatter.parse(startDateController.text);
      final DateTime endDate = formatter.parse(endDateController.text);
      final int duration = endDate.difference(startDate).inDays +
          1; // Tambahkan 1 untuk termasuk hari terakhir

      if (duration >= 0) {
        durationInDaysController.text = duration.toString();
      } else {
        // Tampilkan pesan error jika endDate lebih awal dari startDate
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "Tanggal selesai harus lebih akhir dari tanggal mulai."),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create Premium Class",
              style: FontFamily().regularText.copyWith(
                    fontSize: 16,
                    color: ColorStyle().primaryColors,
                  ))),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
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
                        'Buat Kelas Mentoring Anda Sendiri dan temukan kesempatan untuk membimbing serta mendukung orang lain dalam mencapai tujuan mereka. Jadilah sumber inspirasi bagi mereka yang mencari bimbingan dan arahan .',
                        style: FontFamily().regularText,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevetadButtonWithIcon(
                        title: 'Panduan Pembuatan Kelas',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContohPremiumClass(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TittleTextField(
                  title: "Tingkat Pendidikan",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MyDropdownWidget(
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
                ),
                TittleTextField(
                  title: "Bidang & Minat",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MyDropdownWidget(
                    items: selectedFields,
                    onChanged: (value) {
                      setState(() {
                        selectedField = value.toString();
                      });
                    },
                  ),
                ),

                ///nama kelas ///

                TittleTextField(
                  title: "Nama Kelas",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: nameController,
                    hintText: "input nama kelas",
                    validator: (value) {
                      // Periksa apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Field ini tidak boleh kosong';
                      }

                      return null;
                    },
                  ),
                ),

                ///// harga ////
                TittleTextField(
                  title: "Harga",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: priceController,
                    hintText: "input harga",
                    validator: validatorCapacity,
                  ),
                ),

                ///kapasitas mentee///
                TittleTextField(
                  title: "Kapasitas Mentee",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: maxParticipantsController,
                    hintText: " input kapasitas mentee",
                    validator: validatorCapacity,
                  ),
                ),

                //startDate///
                TittleTextField(
                  title: "Tanggal Mulai",
                  color: ColorStyle().secondaryColors,
                ),
                DatePickerWidget(
                  onDateSelected: (date) {
                    startDateController.text =
                        DateFormat('yyyy-MM-dd').format(date);
                    calculateDuration();
                  },
                  controller: startDateController,
                ),

                ///endDate///
                TittleTextField(
                  title: "Tanggal Selesai",
                  color: ColorStyle().secondaryColors,
                ),
                DatePickerWidget(
                  onDateSelected: (date) {
                    endDateController.text =
                        DateFormat('yyyy-MM-dd').format(date);
                    calculateDuration();
                  },
                  controller: endDateController,
                ),
                //durations////
                TittleTextField(
                  title: "Periode Kegiatan",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: durationInDaysController,
                    hintText: 'Periode kelas',
                    readOnly: true,
                  ),
                ),
                //hari ///
                TittleTextField(
                  title: "Jadwal Hari",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFieldWidget(
                    controller: scheduleController,
                    hintText: " input jadwal hari",
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    ontap: () => showMultiSelect(context),
                    validator: (value) {
                      // Periksa apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Field ini tidak boleh kosong';
                      }

                      return null;
                    },
                  ),
                ),

                ////rician kegiatan///
                TittleTextField(
                  title: "Rincian Kegiatan",
                  color: ColorStyle().secondaryColors,
                ),
                TextFieldWidgetBig(
                    title: 'Deskripsi Kegiatan',
                    validator: (value) {
                      // Periksa apakah field kosong
                      if (value == null || value.isEmpty) {
                        return 'Field ini tidak boleh kosong';
                      }

                      return null;
                    },
                    descriptionController: descriptionCobtroller),

                /// Location///
                TittleTextField(
                  title: "Lokasi",
                  color: ColorStyle().secondaryColors,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: MyDropdownWidget(
                        items: ['Offline', 'Online'],
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value.toString();
                          });
                        },
                      ),
                    ),
                    if (selectedLocation == "Offline") ...[
                      TittleTextField(
                        title: "Alamat",
                        color: ColorStyle().secondaryColors,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFieldWidget(
                          controller: addressController,
                          hintText: "input alamat ",
                        ),
                      ),
                    ],
                  ],
                ),

                //// target learning///
                TittleTextField(
                  title: "Target Pembelajaran",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0;
                            i < targetLearningController.length;
                            i++)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 24),
                            child: TextFieldWidget(
                              controller: targetLearningController[i],
                              hintText: "input target pembelajaran",
                            ),
                          ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: ColorStyle().primaryColors,
                                ),
                                onPressed: () => deleteTextField(
                                    targetLearningController,
                                    targetLearningController.length - 1),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: ColorStyle().primaryColors,
                                ),
                                onPressed: () =>
                                    addTextField(targetLearningController),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ////syarat ketentuan///
                TittleTextField(
                  title: "Syarat & Ketentuan",
                  color: ColorStyle().secondaryColors,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0; i < termsController.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 24),
                            child: TextFieldWidget(
                              controller: termsController[i],
                              hintText: "input syarat & ketentuan",
                            ),
                          ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: ColorStyle().primaryColors,
                                ),
                                onPressed: () => deleteTextField(
                                    termsController,
                                    termsController.length - 1),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: ColorStyle().primaryColors,
                                ),
                                onPressed: () => addTextField(termsController),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    onSubmit();
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
