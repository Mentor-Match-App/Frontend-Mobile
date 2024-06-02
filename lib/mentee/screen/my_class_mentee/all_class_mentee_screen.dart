import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/detail_my_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/payment_error_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class AllClassMenteeScreen extends StatefulWidget {
  @override
  _AllClassMenteeScreenState createState() =>
      _AllClassMenteeScreenState();
}

class _AllClassMenteeScreenState extends State<AllClassMenteeScreen> {
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

    /// buat kelas rejected ketika paymente status rejected

    /// Prioritize Rejected status
    if (transaction.paymentStatus == "Rejected") {
      return 0; // Highest priority
    } else if (isClassActive) {
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

    return 6; // For other or unknown statuses
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
      child: Text(
        title,
        style: FontFamily().boldText.copyWith(
              color: color,
              fontSize: 14,
            ),
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
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final List<TransactionMyClass> classBooking = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
              child: Column(
                children: classBooking.map((data) {
                  int statusButton = getClassStatusPriority(data);
                  final classData = data.transactionClass!;
                  return GestureDetector(
                    onTap: () {
                      if (statusButton == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentErrorScreenMentee(
                              classname: classData.name ?? '',
                              rejectReason: data.rejectReason.toString(),
                              price: classData.price ?? 0,
                              uniqueId: data.uniqueCode ?? 0,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMyClassMenteeScreen(
                              learningMaterial:
                                  classData.learningMaterial ?? [],
                              endDate: DateTime.parse(classData.endDate ?? ''),
                              startDate:
                                  DateTime.parse(classData.startDate ?? ''),
                              targetLearning: classData.targetLearning ?? [],
                              maxParticipants: classData.maxParticipants ?? 0,
                              schedule: classData.schedule ?? '',
                              mentorId: classData.mentorId ?? '',
                              mentorPhoto: classData.mentor!.photoUrl ?? '',
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
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: ColorStyle().tertiaryColors,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              if (statusButton == 0)
                                createStatusButton(
                                    "Rejected", ColorStyle().errorColors)
                              else if (statusButton == 1)
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
                                    "Expired", ColorStyle().blackColors),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          classData.mentor!.photoUrl.toString(),
                                      fit: BoxFit.cover,
                                      width: 98,
                                      height: 98,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          classData.name ?? '',
                                          style: FontFamily().boldText.copyWith(
                                              fontSize: 14,
                                              color:
                                                  ColorStyle().primaryColors),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                            'Mentor : ${classData.mentor!.name}',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return SizedBox(
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
