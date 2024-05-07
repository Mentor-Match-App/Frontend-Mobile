import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/detail_my_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class MyClassBookingMentee extends StatefulWidget {
  @override
  _MyClassBookingMenteeState createState() => _MyClassBookingMenteeState();
}

class _MyClassBookingMenteeState extends State<MyClassBookingMentee> {
  Future<List<TransactionMyClass>>? _userData;
  int getClassStatusPriority(TransactionMyClass transaction) {
    // Gunakan logika yang sama untuk menentukan status
    DateTime now = DateTime.now();
    DateTime startDate =
        DateTime.parse(transaction.transactionClass?.startDate ?? '');
    DateTime endDate =
        DateTime.parse(transaction.transactionClass?.endDate ?? '');
    bool isClassActive = now.isAfter(startDate) && now.isBefore(endDate);
    bool isClassScheduled =
        now.isBefore(startDate) && transaction.paymentStatus == "Approved";
    bool isClassFinished = now.isAfter(endDate);

    if (isClassActive) {
      return 1;
    } else if (isClassScheduled) {
      return 2;
    } else if (transaction.paymentStatus == "Pending") {
      return 3;
    } else if (isClassFinished) {
      return 4;
    } else if (transaction.paymentStatus == "Expired") {
      return 5;
    }

    return 6; // Untuk status lain atau tidak diketahui
  }

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserTransactions().then((transactions) {
      transactions.sort((a, b) =>
          getClassStatusPriority(a).compareTo(getClassStatusPriority(b)));
      return transactions;
    });
  }

// Helper function to create a styled button
  Widget createStatusButton(String title, Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: SmallElevatedButton(
        color: color,
        onPressed: () {}, // Define the action
        height: 28,
        width: 124,
        title: title,
        style: FontFamily().buttonText,
      ),
    );
  }

//// link zoom akses///
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionMyClass>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final List<TransactionMyClass> classBooking = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: classBooking.map((data) {
                int statusButton = getClassStatusPriority(data);
                final classData = data.transactionClass!;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorStyle().tertiaryColors,
                        width: 2,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          if (statusButton == 1)
                            createStatusButton(
                                "Active", ColorStyle().succesColors)
                          else if (statusButton == 2)
                            createStatusButton(
                                "Scheduled", ColorStyle().secondaryColors)
                          else if (statusButton == 3)
                            createStatusButton(
                                "Pending", ColorStyle().pendingColors)
                          else if (statusButton == 4)
                            createStatusButton(
                                "Finished", ColorStyle().disableColors)
                          else if (statusButton == 5)
                            createStatusButton(
                                "Expired", ColorStyle().errorColors),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  classData.mentor!.photoUrl.toString(),
                                  fit: BoxFit.cover,
                                  width: 98,
                                  height: 98,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      classData.name ?? '',
                                      style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                          color: ColorStyle().primaryColors),
                                    ),
                                    const SizedBox(height: 12),
                                    Text('Mentor : ${classData.mentor!.name}',
                                        style: FontFamily().regularText),
                                    Text(
                                        'Durasi : ${classData.durationInDays} Hari',
                                        style: FontFamily().regularText),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailMyClassMenteeScreen(
                                      learningMaterial:
                                          classData.learningMaterial ?? [],
                                      endDate: DateTime.parse(
                                          classData.endDate ?? ''),
                                      startDate: DateTime.parse(
                                          classData.startDate ?? ''),
                                      targetLearning:
                                          classData.targetLearning ?? [],
                                      maxParticipants:
                                          classData.maxParticipants ?? 0,
                                      schedule: classData.schedule ?? '',
                                      mentorId: classData.mentorId ?? '',
                                      mentorPhoto:
                                          classData.mentor!.photoUrl ?? '',
                                      classData: classData,
                                      descriptionKelas:
                                          classData.description.toString(),
                                      terms: classData.terms ?? [],
                                      evaluasi: classData.evaluations ?? [],
                                      linkEvaluasi: classData.zoomLink ?? '',
                                      mentorName: classData.mentor!.name ?? '',
                                      linkZoom: classData.zoomLink ?? '',
                                      namaKelas: classData.name ?? '',
                                      periode: classData.durationInDays ?? 0,
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
          );
        } else {
          return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Center(child: Text('Kamu belum memiliki kelas saat ini')),
              ));
        }
      },
    );
  }
}
