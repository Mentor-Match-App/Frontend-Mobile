import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/detail_my_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/edit_class_rejected.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class MyPremiumClassMentorScreen extends StatefulWidget {
  MyPremiumClassMentorScreen({Key? key}) : super(key: key);

  @override
  State<MyPremiumClassMentorScreen> createState() =>
      _MyPremiumClassMentorScreenState();
}

class _MyPremiumClassMentorScreenState
    extends State<MyPremiumClassMentorScreen> {
  late Future<MyClassMentorMondel> classData;
  int _getPriority(Class userClass) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(
        userClass.startDate.toString()); // Asumsi startDate tidak null
    DateTime endDate = DateTime.parse(
        userClass.endDate.toString()); // Asumsi endDate tidak null

    int getAvailableSlotCount(Class userClass) {
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

    // Tentukan warna tombol dan teks berdasarkan kondisi status kelas

    if (isAvailable && totalApprovedAndPendingCount < maxParticipants) {
      buttonColor = ColorStyle().secondaryColors;
      buttonText = "Available";
    } else if (!isAvailable && !isVerified && !isActive && isRejected) {
      // Kondisi untuk "Rejected"
      buttonColor = ColorStyle().errorColors; // Warna untuk status "Rejected"
      buttonText = "Rejected";
      //kondisi pending
    } else if (!isAvailable &&
        !isVerified &&
        !isActive &&
        now.isBefore(startDate)) {
      buttonColor = ColorStyle().pendingColors;
      buttonText = "Pending";
    } else if (totalApprovedAndPendingCount >= maxParticipants && !isActive) {
      buttonColor = ColorStyle().fullbookedColors;
      buttonText = "Full";
      // ketika startDate = now , dan now <+ endDate
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
      // Penanganan default jika ada, untuk kasus yang tidak tertangani oleh kondisi di atas
      buttonColor = ColorStyle().primaryColors; // Asumsi warna default
      buttonText = "Unavailable"; // Teks default
    }
    // Kembalikan prioritas yang dihitung
    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
    // Lakukan perhitungan prioritas berdasarkan teks tombol
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

  @override
  void initState() {
    super.initState();
    // Initialize the future without passing userId
    classData = ListClassMentor().fetchClassData();

    /// mebuat sort sesuai dengan prioritas status
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
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.user?.userClass != null) {
          var userClass = snapshot.data!.user!.userClass!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: userClass.map((data) {
                  int approvedTransactionsCount = data.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .length ??
                      0;

                  int statusButton = _getPriority(data);
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (statusButton == 1)
                                createStatusButton(
                                    "Rejected", ColorStyle().errorColors),
                              if (statusButton == 2)
                                createStatusButton(
                                    "Pending", ColorStyle().pendingColors),
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
                              SizedBox(height: 12),
                              Text(
                                  //nama kelas
                                  data.name ?? '',
                                  style: FontFamily().titleText.copyWith(
                                        color: ColorStyle().secondaryColors,
                                      )),
                              SizedBox(height: 12),
                              Text(
                                'Jumlah mentee terdaftar : ${approvedTransactionsCount}',
                                style: FontFamily().regularText,
                              ),

                              const SizedBox(height: 12),
                              Text(
                                //durationIndays
                                'Durasi kelas : ${data.durationInDays} hari',
                                style: FontFamily().regularText,
                              ),
                              // buat align text button di kanan menuju DetailMyclass namun aoabila statusnya rejected maka ke editrejectedClaas
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    if (statusButton == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditRejectedClass(
                                            classData: data,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMyClassMentorScreen(
                                            feedbacks: data.feedbacks ?? [],
                                            addressMentoring:
                                                data.address ?? 'Meeting Zoom',
                                            locationMentoring:
                                                data.location ?? '',
                                            approvedTransactionsCount:
                                                approvedTransactionsCount,
                                            transactions:
                                                data.transactions ?? [],
                                            evaluation: data.evaluations ?? [],
                                            learningMaterial:
                                                data.learningMaterial ?? [],
                                            userClass: data,
                                            aksesLinkZoom: data.zoomLink ?? '',
                                            deskripsiKelas:
                                                data.description.toString(),
                                            classid: data.id.toString(),
                                            durationInDays:
                                                data.durationInDays ?? 0,
                                            endDate: DateTime.parse(
                                                data.endDate ?? ''),
                                            startDate: DateTime.parse(
                                                data.startDate ?? ''),
                                            term: data.terms ?? [],
                                            maxParticipants:
                                                data.maxParticipants ?? 0,
                                            schedule: data.schedule ?? '',
                                            targetLearning:
                                                data.targetLearning ?? [],
                                            linkZoom: data.zoomLink ?? '',
                                            namaKelas: data.name ?? '',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Lihat Kelas',
                                    style: FontFamily().buttonText.copyWith(
                                          color: ColorStyle().secondaryColors,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
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
