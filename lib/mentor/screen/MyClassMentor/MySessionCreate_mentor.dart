import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/model/myClass_mentor_model.dart';
import 'package:mentormatch_apps/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
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
      child: SmallElevatedButton(
        color: color,
        onPressed: () {}, // Tentukan tindakan yang diinginkan
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
          return CircularProgressIndicator();
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

                // Konversi waktu UTC ke zona waktu Indonesia (WIB)
                // final startTimeInWIB =
                //     DateTime.parse(session.startTime!).add(timeZoneOffset);
                // final endTimeInWIB =
                //     DateTime.parse(session.endTime!).add(timeZoneOffset);
                // final formattedStartTimeWIB =
                //     formatOutput.format(startTimeInWIB);
                // final formattedEndTimeWIB = formatOutput.format(endTimeInWIB);

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorStyle().tertiaryColors, // Warna border
                        width: 1, // Lebar border
                      ),
                      color: Colors
                          .transparent, // Warna bagian dalam, bisa diatur menjadi transparent atau null
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
                                  color: ColorStyle().secondaryColors),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Jadwal : ${formattedJadwal}',
                              style: FontFamily().regularText,
                            ),
                            Text(
                              'Jam : ${formattedStartTime} - ${formattedEndTime}',
                              style: FontFamily().regularText,
                            ),
                            Text(
                              'Jumlah Peserta: ${session.participant!.length} peserta',
                              style: FontFamily().regularText,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 150,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: ColorStyle().primaryColors,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      primary: ColorStyle().whiteColors,
                                    ),
                                    onPressed: () {
                                      final zommLink = session.zoomLink ?? '';
                                      _launchURL(zommLink);
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
          return Center(
            child: Text("Tidak ada session", style: FontFamily().boldText),
          );
        }
      },
    );
  }
}
