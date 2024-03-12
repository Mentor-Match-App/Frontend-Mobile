import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/model/myClass_mentor_model.dart';

import 'package:mentormatch_apps/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionCreate extends StatefulWidget {
  MySessionCreate({Key? key}) : super(key: key);

  @override
  State<MySessionCreate> createState() => _MySessionCreateState();
}

class _MySessionCreateState extends State<MySessionCreate> {
  late Future<List<Session>> _sessionsFuture;
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

  @override
  void initState() {
    super.initState();
    // Initialize the future without passing userId
    _sessionsFuture = ListClassMentor().fetchSessionsForCurrentUser();
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
                /////// format tanggal dan waktu///////
                DateTime parsedJadwal = DateTime.parse(session.dateTime!);
                String formattedJadwal =
                    DateFormat('dd MMMM yyyy HH:mm').format(parsedJadwal);

                final DateFormat formatOutput = DateFormat("HH:mm");
                final String formattedStartTime =
                    formatOutput.format(DateTime.parse(session.startTime!));
                final String formattedEndTime =
                    formatOutput.format(DateTime.parse(session.endTime!));
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
                              'Jam : ${formattedStartTime } - ${formattedEndTime}',
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
          return Center(child: Text("No Sessions Found"));
        }
      },
    );
  }
}
