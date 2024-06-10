import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/detail_my_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/edit_class_rejected.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class PremiumClassMentorScreen extends StatefulWidget {
  PremiumClassMentorScreen({Key? key}) : super(key: key);

  @override
  State<PremiumClassMentorScreen> createState() =>
      _PremiumClassMentorScreenState();
}

class _PremiumClassMentorScreenState extends State<PremiumClassMentorScreen> {
  late Future<MyClassMentorMondel> classData;

  int _getPriority(AllClass userClass) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(userClass.startDate.toString());
    DateTime endDate = DateTime.parse(userClass.endDate.toString());

    int getAvailableSlotCount(AllClass userClass) {
      int approvedCount = userClass.transactions
              ?.where((t) => t.paymentStatus == "Approved")
              .length ??
          0;
      int pendingCount = userClass.transactions
              ?.where((t) => t.paymentStatus == "Pending")
              .length ??
          0;
      int totalApprovedAndPendingCount = approvedCount + pendingCount;
      return totalApprovedAndPendingCount;
    }

    int totalApprovedAndPendingCount = getAvailableSlotCount(userClass);

    bool isVerified = userClass.isVerified!;
    bool isActive = userClass.isActive!;
    bool isAvailable = userClass.isAvailable!;
    int maxParticipants = userClass.maxParticipants!;
    Color buttonColor = ColorStyle().primaryColors;
    String buttonText = "Available";
    bool isRejected = userClass.rejectReason != null;

    if (isAvailable && totalApprovedAndPendingCount < maxParticipants) {
      buttonColor = ColorStyle().secondaryColors;
      buttonText = "Available";
    } else if (!isAvailable && !isVerified && !isActive && isRejected) {
      buttonColor = ColorStyle().errorColors;
      buttonText = "Rejected";
    } else if (!isAvailable &&
        !isVerified &&
        !isActive &&
        now.isBefore(startDate)) {
      buttonColor = ColorStyle().pendingColors;
      buttonText = "Pending";
    } else if (totalApprovedAndPendingCount >= maxParticipants && !isActive) {
      buttonColor = ColorStyle().fullbookedColors;
      buttonText = "Full";
    } else if (isActive) {
      buttonColor = ColorStyle().succesColors;
      buttonText = "Active";
    } else if (totalApprovedAndPendingCount > 0 && now.isAfter(endDate)) {
      buttonColor = ColorStyle().disableColors;
      buttonText = "Completed";
    } else if (totalApprovedAndPendingCount == 0 && now.isAfter(startDate)) {
      buttonColor = ColorStyle().blackColors;
      buttonText = "Expired";
    } else {
      buttonColor = ColorStyle().primaryColors;
      buttonText = "Unavailable";
    }

    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
    switch (buttonText) {
      case "Rejected":
        return 1;
      case "Pending":
        return 2;
      case "Full":
        return 3;
      case "Active":
        return 4;
      case "Completed":
        return 5;
      case "Expired":
        return 6;
      case "Unavailable":
        return 7;
      default:
        return 8;
    }
  }

  Widget createStatusButton(String title, Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: FontFamily().boldText.copyWith(
              color: color,
              fontSize: 12,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    classData = ListClassMentor().fetchClassData();
    classData.then((value) {
      value.user?.userClass?.sort((a, b) {
        return _getPriority(a).compareTo(_getPriority(b));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyClassMentorMondel>(
      future: classData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: MediaQuery.of(context).size.height / 2.0,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var userClass = snapshot.data!.user?.userClass;
          if (userClass == null || userClass.isEmpty) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Center(child: Text('Kamu belum memiliki kelas saat ini')),
              ),
            );
          }

          var filteredClasses = userClass.where((data) {
            int priority = _getPriority(data);
            return priority != 1 &&
                priority != 2; // Exclude "Rejected" and "Pending"
          }).toList();

          if (filteredClasses.isEmpty) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Center(child: Text('Kamu belum memiliki kelas saat ini')),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
              child: Column(
                children: filteredClasses.map((data) {
                  int approvedTransactionsCount = data.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .length ??
                      0;

                  int statusButton = _getPriority(data);
                  return GestureDetector(
                    onTap: () {
                      if (statusButton == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditRejectedClass(
                              classData: data,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMyClassMentorScreen(
                              feedbacks: data.feedbacks ?? [],
                              addressMentoring: data.address ?? 'Meeting Zoom',
                              locationMentoring: data.location ?? '',
                              approvedTransactionsCount:
                                  approvedTransactionsCount,
                              transactions: data.transactions ?? [],
                              evaluation: data.evaluations ?? [],
                              learningMaterial: data.learningMaterial ?? [],
                              userClass: data,
                              aksesLinkZoom: data.zoomLink ?? '',
                              deskripsiKelas: data.description.toString(),
                              classid: data.id.toString(),
                              durationInDays: data.durationInDays ?? 0,
                              endDate: DateTime.parse(data.endDate ?? ''),
                              startDate: DateTime.parse(data.startDate ?? ''),
                              term: data.terms ?? [],
                              maxParticipants: data.maxParticipants ?? 0,
                              schedule: data.schedule ?? '',
                              targetLearning: data.targetLearning ?? [],
                              linkZoom: data.zoomLink ?? '',
                              namaKelas: data.name ?? '',
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: ColorStyle().whiteColors,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (statusButton == 3)
                                createStatusButton(
                                    "Full", ColorStyle().fullbookedColors),
                              if (statusButton == 4)
                                createStatusButton(
                                    "Active", ColorStyle().succesColors),
                              if (statusButton == 5)
                                createStatusButton(
                                    "Completed", ColorStyle().disableColors),
                              if (statusButton == 6)
                                createStatusButton(
                                    "Expired", ColorStyle().blackColors),
                              if (statusButton == 7)
                                createStatusButton(
                                    "Unavailable", ColorStyle().primaryColors),
                              if (statusButton == 8)
                                createStatusButton(
                                    "Available", ColorStyle().secondaryColors),
                              const SizedBox(height: 12),
                              Text(
                                data.name ?? '',
                                style: FontFamily().boldText.copyWith(
                                    fontSize: 14,
                                    color: ColorStyle().blackColors),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Jumlah mentee terdaftar : ${approvedTransactionsCount} orang',
                                style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().blackColors,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Durasi kelas                        : ${data.durationInDays} hari',
                                style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().blackColors,
                                    ),
                              ),
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
