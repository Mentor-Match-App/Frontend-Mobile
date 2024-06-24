import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/detail_my_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumClassMenteeScreen extends StatefulWidget {
  @override
  _PremiumClassMenteeScreenState createState() =>
      _PremiumClassMenteeScreenState();
}

class _PremiumClassMenteeScreenState extends State<PremiumClassMenteeScreen> {
  Future<List<TransactionMyClass>>? _userData;

  int getClassStatusPriority(TransactionMyClass transaction) {
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
    } else if (isClassFinished) {
      return 3;
    }

    return 4;
  }

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserTransactions().then((transactions) {
      transactions.sort((a, b) =>
          getClassStatusPriority(a).compareTo(getClassStatusPriority(b)));
      return transactions
          .where((transaction) => getClassStatusPriority(transaction) != 4)
          .toList();
    });
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

  _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMyClassMenteeScreen(
                            learningMaterial: classData.learningMaterial ?? [],
                            endDate: DateTime.parse(classData.endDate ?? ''),
                            startDate:
                                DateTime.parse(classData.startDate ?? ''),
                            targetLearning: classData.targetLearning ?? [],
                            maxParticipants: classData.maxParticipants ?? 0,
                            schedule: classData.schedule ?? '',
                            mentorId: classData.mentorId ?? '',
                            mentorPhoto: classData.mentor!.photoUrl ?? '',
                            classData: classData,
                            descriptionKelas: classData.description.toString(),
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
                                    "Finished", ColorStyle().disableColors),
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
                                              color: ColorStyle().blackColors),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                            'Mentor : ${classData.mentor!.name}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: ColorStyle()
                                                    .disableColors)),
                                        Text(
                                            'Durasi : ${classData.durationInDays} Hari',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: ColorStyle()
                                                    .disableColors)),
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Center(child: Text('Kamu belum memiliki kelas saat ini')),
              ));
        }
      },
    );
  }
}
