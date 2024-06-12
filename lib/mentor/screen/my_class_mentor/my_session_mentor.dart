import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionCreate extends StatefulWidget {
  MySessionCreate({Key? key}) : super(key: key);

  @override
  State<MySessionCreate> createState() => _MySessionCreateState();
}

class _MySessionCreateState extends State<MySessionCreate> {
  late Future<List<Session>> _sessionsFuture;

  int _getPriority(Session userSessions) {
    String buttonText = "Available";
    // buttonCollor scheduled ketika isActive bernilai true + belum

    if (userSessions.isActive == true) {
      buttonText = "Scheduled";
      // buttonCollor full ketika participant.length == maxParticipant + startTime nya belum mulai + isActive bernilai false
    }
    if (userSessions.participant!.length == userSessions.maxParticipants &&
        DateTime.now().isBefore(DateTime.parse(userSessions.startTime!)) &&
        DateTime.now().isBefore(DateTime.parse(userSessions.endTime!)) &&
        userSessions.isActive == true) {
      buttonText = "Full";
    }

    // buttonCollor active ketika isActive bernilai false + participant.length >= 1 + dan waktunya masih berlangsung
    if (userSessions.isActive == false &&
        userSessions.participant!.length >= 1 &&
        DateTime.now().isBefore(DateTime.parse(userSessions.endTime!))) {
      buttonText = "Active";
    }
    if (userSessions.isActive == false &&
        userSessions.participant!.length == 0 &&
        DateTime.now().isAfter(DateTime.parse(userSessions.startTime!))) {
      buttonText = "Expired";
    }

    // buttonCollor finished ketika isActive bernilai false + participant.length >= 1 + sudah lewat endTime
    else if (userSessions.isActive == false &&
        userSessions.participant!.length >= 1 &&
        DateTime.now().isAfter(DateTime.parse(userSessions.endTime!))) {
      buttonText = "Finished";
    }

    return _calculatePriority(buttonText);
  }

// susunannya ad
  int _calculatePriority(String buttonText) {
    if (buttonText == "Active") {
      return 1;
    } else if (buttonText == "Scheduled") {
      return 2;
    } else if (buttonText == "Full") {
      return 3;
    } else if (buttonText == "Finished") {
      return 4;
    } else if (buttonText == "Expired") {
      return 5;
    } else {
      return 0;
    }
  }

  //// link zoom akses///
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  createStatusButton(String title, Color color) {
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

    _sessionsFuture = ListClassMentor().fetchSessionsForCurrentUser();

    /// Membuat sort sesuai dengan prioritas status
    _sessionsFuture.then((value) {
      value.sort((a, b) {
        return _getPriority(a).compareTo(_getPriority(b));
      });
      setState(() {}); // Atur ulang state setelah sorting dilakukan
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Session>>(
      future:
          _sessionsFuture, // Asumsi ini adalah Future yang Anda panggil untuk mendapatkan data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Menggunakan SingleChildScrollView dan Column untuk menampilkan data
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.map((session) {
                int statusButton = _getPriority(session);

                DateTime parsedJadwal = DateTime.parse(session.dateTime!);
                String formattedJadwal =
                    DateFormat('dd MMMM yyyy').format(parsedJadwal);

                final DateFormat formatOutput = DateFormat("HH:mm");
                final String formattedStartTime =
                    formatOutput.format(DateTime.parse(session.startTime!));
                final String formattedEndTime =
                    formatOutput.format(DateTime.parse(session.endTime!));

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (statusButton == 1)
                              createStatusButton(
                                  "Active", ColorStyle().succesColors)
                            else if (statusButton == 2)
                              createStatusButton(
                                  "Scheduled", ColorStyle().secondaryColors)
                            else if (statusButton == 3)
                              createStatusButton(
                                  "Full", ColorStyle().fullbookedColors)
                            else if (statusButton == 4)
                              createStatusButton(
                                  "Finished", ColorStyle().disableColors)
                            else if (statusButton == 5)
                              createStatusButton(
                                  "Expired", ColorStyle().errorColors),
                            const SizedBox(height: 12),
                            Text(
                              session.title!,
                              style: FontFamily().boldText.copyWith(
                                  fontSize: 14,
                                  color: ColorStyle().blackColors),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Jadwal               : ${formattedJadwal}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            ),
                            Text(
                              'Jam                    : ${formattedStartTime} - ${formattedEndTime}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            ),
                            Text(
                              'Jumlah Peserta : ${session.participant!.length} peserta',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 150,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: ColorStyle().primaryColors,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: ColorStyle().whiteColors,
                                    ),
                                    onPressed: () {
                                      if (session.zoomLink == null ||
                                          session.zoomLink!.isEmpty) {
                                        showTopSnackBar(
                                            context, "Link Zoom belum tersedia",
                                            leftBarIndicatorColor:
                                                ColorStyle().errorColors);
                                      } else {
                                        _launchURL(session.zoomLink!);
                                      }
                                    },
                                    icon: Icon(Icons.link),
                                    label: Text('Join Session',
                                        style: FontFamily()
                                            .regularText
                                            .copyWith(
                                              color: ColorStyle().whiteColors,
                                            )),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Center(child: Text('Kamu belum memiliki session saat ini')),
              ));
        }
      },
    );
  }
}
