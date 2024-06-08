import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/detail_my_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

// Enum to define different class statuses
enum ClassStatus { active, inactive, scheduled }

class PremiumClassMentorScreen extends StatefulWidget {
  PremiumClassMentorScreen({Key? key}) : super(key: key);

  @override
  State<PremiumClassMentorScreen> createState() =>
      _PremiumClassMentorScreenState();
}

class _PremiumClassMentorScreenState extends State<PremiumClassMentorScreen> {
  // Future to hold the fetched class data
  late Future<MyClassMentorMondel> classData;

  @override
  void initState() {
    super.initState();
    // Initialize the future without passing userId
    classData = ListClassMentor().fetchClassData();
  }

  // Method to determine the class status based on dates and transactions
  ClassStatus getClassStatus(AllClass classData) {
    DateTime now = DateTime.now();
    DateTime? startDate = classData.startDate != null
        ? DateTime.parse(classData.startDate!)
        : null;
    DateTime? endDate =
        classData.endDate != null ? DateTime.parse(classData.endDate!) : null;

    // Check if there is any approved transaction before the start date
    bool hasApprovedTransactionBeforeStart = classData.transactions?.any(
            (transaction) =>
                transaction.paymentStatus == "Approved" &&
                (startDate == null || now.isBefore(startDate))) ??
        false;

    print("Class Name: ${classData.name}");
    print("Start Date: $startDate");
    print("End Date: $endDate");
    print(
        "Approved Transactions Before Start: $hasApprovedTransactionBeforeStart");

    if (startDate != null && endDate != null) {
      if (now.isAfter(startDate) && now.isBefore(endDate)) {
        print("Status: Active");
        return ClassStatus.active;
      } else if (hasApprovedTransactionBeforeStart) {
        // Condition for approved transactions but class hasn't started
        print("Status: Scheduled (Approved transactions but hasn't started)");
        return ClassStatus.scheduled;
      } else if (now.isBefore(startDate)) {
        print(
            "Status: Inactive (Before Start Date and No Approved Transactions)");
        return ClassStatus.inactive;
      } else if (now.isAfter(endDate)) {
        print("Status: Inactive");
        return ClassStatus.inactive;
      }
    } else if (hasApprovedTransactionBeforeStart) {
      // If dates are not set correctly but there are approved transactions
      print("Status: Scheduled (Dates not set but approved transactions)");
      return ClassStatus.scheduled;
    }

    // Default to inactive if no other condition is met
    print("Status: Inactive");
    return ClassStatus.inactive;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyClassMentorMondel>(
      future: classData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.user?.userClass != null) {
          var userClass = snapshot.data!.user!.userClass!;
          var filteredClasses = userClass.where((classData) {
            var status = getClassStatus(classData);
            return status == ClassStatus.scheduled ||
                status == ClassStatus.active;
          }).toList();

          if (filteredClasses.length == 0) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Kamu belum memiliki kelas saat ini'),
                ),
              ),
            );
          }

          print("Filtered Classes Length: ${filteredClasses.length}");
          print(
              "Filtered Classes: ${filteredClasses.map((e) => e.name).toList()}");

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
              child: Column(
                children: filteredClasses.map((classData) {
                  var approvedTransactions = classData.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .toList() ??
                      [];

                  print("Class: ${classData.name}");
                  print(
                      "Approved Transactions: ${approvedTransactions.length}");

                  if (approvedTransactions.isEmpty) {
                    return Container();
                  }

                  String menteeNames = approvedTransactions
                      .map((transaction) => transaction.user!.name as String)
                      .join(', ');

                  ClassStatus status = getClassStatus(classData);

                  Color buttonColor;
                  String buttonText;
                  switch (status) {
                    case ClassStatus.active:
                      buttonColor = ColorStyle().succesColors;
                      buttonText = "Active";
                      break;
                    case ClassStatus.scheduled:
                      buttonColor = ColorStyle().secondaryColors;
                      buttonText = "Scheduled";
                      break;
                    default:
                      buttonColor = ColorStyle().secondaryColors;
                      buttonText = "Scheduled";
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMyClassMentorScreen(
                            feedbacks: classData.feedbacks ?? [],
                            addressMentoring: classData.address ?? '',
                            locationMentoring: classData.location ?? '',
                            approvedTransactionsCount:
                                approvedTransactions.length,
                            transactions: classData.transactions ?? [],
                            evaluation: classData.evaluations ?? [],
                            learningMaterial: classData.learningMaterial ?? [],
                            userClass: classData,
                            aksesLinkZoom: classData.zoomLink ?? '',
                            deskripsiKelas: classData.description.toString(),
                            classid: classData.id.toString(),
                            durationInDays: classData.durationInDays ?? 0,
                            endDate: DateTime.parse(classData.endDate ?? ''),
                            startDate:
                                DateTime.parse(classData.startDate ?? ''),
                            term: classData.terms ?? [],
                            maxParticipants: classData.maxParticipants ?? 0,
                            schedule: classData.schedule ?? '',
                            targetLearning: classData.targetLearning ?? [],
                            linkZoom: classData.zoomLink ?? '',
                            namaKelas: classData.name ?? '',
                          ),
                        ),
                      );
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  buttonText,
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 12,
                                      color: ColorStyle().blackColors),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                classData.name ?? '',
                                style: FontFamily().boldText.copyWith(
                                    fontSize: 14,
                                    color: ColorStyle().blackColors),
                              ),
                              const SizedBox(height: 8),
                              Text('Mentee : $menteeNames',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorStyle().disableColors)),
                              const SizedBox(height: 4),
                              Text(
                                  'Durasi   : ${classData.durationInDays} Hari',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorStyle().disableColors)),
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
                    Center(child: Text('kamu belum memiliki kelas saat ini')),
              ));
        }
      },
    );
  }
}
