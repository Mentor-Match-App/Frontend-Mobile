import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/myClass_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/detail_myclass_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

enum ClassStatus { active, inactive, scheduled }

class MyClassCreate extends StatefulWidget {
  MyClassCreate({Key? key}) : super(key: key);

  @override
  State<MyClassCreate> createState() => _MyClassCreateState();
}

class _MyClassCreateState extends State<MyClassCreate> {
  late Future<MyClassMentorMondel> classData;

  @override
  void initState() {
    super.initState();
    // Initialize the future without passing userId
    classData = ListClassMentor().fetchClassData();
  }

  ClassStatus getClassStatus(Class classData) {
    DateTime now = DateTime.now();
    DateTime? startDate = classData.startDate != null
        ? DateTime.parse(classData.startDate!)
        : null;
    DateTime? endDate =
        classData.endDate != null ? DateTime.parse(classData.endDate!) : null;

    // Memeriksa apakah ada transaksi yang disetujui sebelum tanggal mulai
    bool hasApprovedTransactionBeforeStart = classData.transactions?.any(
            (transaction) =>
                transaction.paymentStatus == "Approved" &&
                (startDate == null || now.isBefore(startDate))) ??
        false;

    if (startDate != null && endDate != null) {
      if (now.isAfter(startDate) && now.isBefore(endDate)) {
        return ClassStatus.active;
      } else if (hasApprovedTransactionBeforeStart) {
        // Kondisi untuk transaksi disetujui tetapi kelas belum dimulai
        return ClassStatus.scheduled;
      } else if (now.isBefore(startDate)) {
        return ClassStatus.scheduled;
      } else if (now.isAfter(endDate)) {
        return ClassStatus.inactive;
      }
    } else if (hasApprovedTransactionBeforeStart) {
      // Jika tanggal tidak diatur dengan benar, tetapi ada transaksi yang disetujui
      return ClassStatus.scheduled;
    }

    // Jika tidak ada tanggal yang diatur atau kondisi lainnya tidak terpenuhi
    return ClassStatus.inactive;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyClassMentorMondel>(
      future: classData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.user?.userClass != null) {
          var userClass = snapshot.data!.user!.userClass!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: userClass.map((classData) {
                  // Filtering transactions with "Approved" payment status
                  var approvedTransactions = classData.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .toList() ??
                      [];

                  if (approvedTransactions.isEmpty) {
                    return Container(); // Return an empty container if no transactions match
                  }

                  String menteeNames = approvedTransactions
                      .map((transaction) => transaction.user!.name as String)
                      .join(', ');

                  ClassStatus status = getClassStatus(classData);

                  // Decide button color and title based on class status
                  Color buttonColor;
                  String buttonText;
                  switch (status) {
                    case ClassStatus.active:
                      buttonColor = ColorStyle().succesColors;
                      buttonText = "Active";
                      break;
                    case ClassStatus.inactive:
                      buttonColor = ColorStyle().secondaryColors;
                      buttonText = "Scheduled";
                      break;
                    default:
                      buttonColor =
                          ColorStyle().secondaryColors; // Default color
                      buttonText = "Scheduled"; // Default text
                  }

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorStyle().tertiaryColors,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: SmallElevatedButton(
                                color: buttonColor,
                                onPressed: () {},
                                height: 30,
                                width: 124,
                                title: buttonText,
                                style: FontFamily().buttonText,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              classData.name ?? '',
                              style: FontFamily().boldText.copyWith(
                                  fontSize: 14,
                                  color: ColorStyle().primaryColors),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Mentee: $menteeNames',
                              style: TextStyle(/* Your TextStyle here */),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Durasi: ${classData.durationInDays} Hari',
                              style: FontFamily().regularText,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMyClassMentorScreen(
                                        addressMentoring:
                                            classData.address ?? '',
                                        locationMentoring:
                                            classData.location ?? '',
                                        approvedTransactionsCount:
                                            approvedTransactions.length,
                                        transactions:
                                            classData.transactions ?? [],
                                        evaluation: classData.evaluations ?? [],
                                        learningMaterial:
                                            classData.learningMaterial ?? [],
                                        userClass: classData,
                                        aksesLinkZoom: classData.zoomLink ?? '',
                                        deskripsiKelas:
                                            classData.description.toString(),
                                        classid: classData.id.toString(),
                                        durationInDays:
                                            classData.durationInDays ?? 0,
                                        endDate: DateTime.parse(
                                            classData.endDate ?? ''),
                                        startDate: DateTime.parse(
                                            classData.startDate ?? ''),
                                        term: classData.terms ?? [],
                                        maxParticipants:
                                            classData.maxParticipants ?? 0,
                                        schedule: classData.schedule ?? '',
                                        targetLearning:
                                            classData.targetLearning ?? [],
                                        linkZoom: classData.zoomLink ?? '',
                                        namaKelas: classData.name ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Lihat Detail',
                                  style: FontFamily().boldText.copyWith(
                                      color: ColorStyle().secondaryColors,
                                      fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Center(child: Text('No data'));
        }
      },
    );
  }
}
