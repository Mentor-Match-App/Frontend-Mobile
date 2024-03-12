import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/myClass_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/detail_myclass_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/MyClassMentor/edit_class_rejected.dart';
import 'package:mentormatch_apps/mentor/service/myClassCreate_Mentor_service.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the future without passing userId
    classData = ListClassMentor().fetchClassData();
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
                  DateTime now = DateTime.now();
                  DateTime startDate = DateTime.parse(
                      classData.startDate!); // Asumsi startDate tidak null
                  DateTime endDate = DateTime.parse(
                      classData.endDate!); // Asumsi endDate tidak null
                  int approvedTransactionsCount = classData.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .length ??
                      0;
                  bool isVerified = classData.isVerified!;
                  bool isActive = classData.isActive!;
                  bool isAvailable = classData.isAvailable!;
                  int maxParticipants = classData.maxParticipants!;
                  Color buttonColor = ColorStyle().primaryColors;
                  String buttonText = "Available";
                  bool isRejected = classData.rejectReason != null;

                  // Widget trailingIcon = SizedBox();

                  if (isAvailable &&
                      approvedTransactionsCount < maxParticipants) {
                    buttonColor = ColorStyle().secondaryColors;
                    buttonText = "Available";
                  } else if (!isAvailable &&
                      !isVerified &&
                      !isActive &&
                      isRejected) {
                    // Kondisi untuk "Rejected"
                    buttonColor = ColorStyle()
                        .errorColors; // Warna untuk status "Rejected"
                    buttonText = "Rejected";
                  } else if (!isAvailable && !isVerified && !isActive) {
                    buttonColor = ColorStyle().pendingColors;
                    buttonText = "Pending";
                  } else if (approvedTransactionsCount >= maxParticipants &&
                      !isActive) {
                    buttonColor = ColorStyle().fullbookedColors;
                    buttonText = "Full";
                  } else if (isActive &&
                      now.isAfter(startDate) &&
                      now.isBefore(endDate)) {
                    buttonColor = ColorStyle().succesColors;
                    buttonText = "Active";
                  } else if (approvedTransactionsCount > 0 &&
                      now.isAfter(endDate)) {
                    buttonColor = ColorStyle().disableColors;
                    buttonText = "Completed";
                  } else if (approvedTransactionsCount == 0 &&
                      now.isAfter(startDate)) {
                    buttonColor = ColorStyle().blackColors;
                    buttonText = "Expired";
                  } else {
                    // Penanganan default jika ada, untuk kasus yang tidak tertangani oleh kondisi di atas
                    buttonColor =
                        ColorStyle().primaryColors; // Asumsi warna default
                    buttonText = "Unavailable"; // Teks default
                  }
                  String menteeNames = classData.transactions!
                      .map((transaction) => transaction.user!.name
                          as String) // Extracting the name from each transaction.
                      .join(
                          ', '); // Joining all names with a comma and space for readability.

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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //buat agar tidak overflow text gunakan expanded atau flexible
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    classData.name ?? '',
                                    style: FontFamily().boldText.copyWith(
                                        fontSize: 14,
                                        color: ColorStyle().primaryColors),
                                  ),
                                ),
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
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Jumlah mentee terdaftar : ${approvedTransactionsCount}',
                              style: TextStyle(/* Your TextStyle here */),
                            ),
                            const SizedBox(height: 12),
                            // You need to adjust how you access transaction names here. Assuming each classData has transactions that is a list
                            Text(
                              'Durasi : ${classData.durationInDays} Hari',
                              style: FontFamily().regularText,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  if (!isAvailable &&
                                      !isVerified &&
                                      !isActive &&
                                      isRejected) {
                                    // Jika kelas ditolak, arahkan ke halaman EditRejectedClass
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditRejectedClass(
                                          classData: classData,
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Untuk kondisi lain, arahkan ke halaman DetailMyClassMentorScreen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailMyClassMentorScreen(
                                          addressMentoring: classData.address ??
                                              'Meeting Zoom',
                                          locationMentoring:
                                              classData.location ?? '',
                                          approvedTransactionsCount:
                                              approvedTransactionsCount,
                                          transactions:
                                              classData.transactions ?? [],
                                          evaluation:
                                              classData.evaluations ?? [],
                                          learningMaterial:
                                              classData.learningMaterial ?? [],
                                          userClass: classData,
                                          aksesLinkZoom:
                                              classData.zoomLink ?? '',
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
                                  }
                                },
                                child: Text(
                                  'Lihat Detail',
                                  style: FontFamily().boldText.copyWith(
                                      color: ColorStyle().secondaryColors,
                                      fontSize: 14),
                                ),
                              ),
                            ),
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
