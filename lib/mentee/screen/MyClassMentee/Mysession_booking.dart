import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/model/myClass_model.dart';
import 'package:mentormatch_apps/mentee/service/myClassService/myClass_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionBooking extends StatefulWidget {
  @override
  _MySessionBookingState createState() => _MySessionBookingState();
}

class _MySessionBookingState extends State<MySessionBooking> {
  Future<List<ParticipantMyClass>>? _userData;

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserSessions();
  }

//// link zoom akses///
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParticipantMyClass>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<ParticipantMyClass> participants = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: participants.map((participant) {
                final session = participant.session!;
                                final timeZoneOffset = Duration(hours: 7);
                DateTime parsedJadwal =
                    DateTime.parse(session.dateTime!).add(timeZoneOffset);
                String formattedJadwal =
                    DateFormat('dd MMMM yyyy').format(parsedJadwal);

                final DateFormat formatOutput = DateFormat("HH:mm");
                final String formattedStartTime =
                    formatOutput.format(DateTime.parse(session.startTime!));
                final String formattedEndTime =
                    formatOutput.format(DateTime.parse(session.endTime!));

                // Konversi waktu UTC ke zona waktu Indonesia (WIB)
                final startTimeInWIB =
                    DateTime.parse(session.startTime!).add(timeZoneOffset);
                final endTimeInWIB =
                    DateTime.parse(session.endTime!).add(timeZoneOffset);
                final formattedStartTimeWIB =
                    formatOutput.format(startTimeInWIB);
                final formattedEndTimeWIB = formatOutput.format(endTimeInWIB);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorStyle().tertiaryColors, // Warna border
                        width: 2, // Lebar border
                      ),
                      color: Colors
                          .transparent, // Warna bagian dalam, bisa diatur menjadi transparent atau null
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  session.mentor!.photoUrl.toString(),
                                  fit: BoxFit.cover,
                                  width: 98,
                                  height: 98,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      session.title ?? '',
                                      style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                          color: ColorStyle().primaryColors),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Mentor : ${session.mentor!.name}',
                                      style: FontFamily().regularText,
                                    ),
                                    Text(
                                      'Jadwal : ${formattedJadwal}',
                                      style: FontFamily().regularText,
                                    ),
                                    Text(
                                      'Jam : ${formattedStartTimeWIB} - ${formattedEndTimeWIB}',
                                      style: FontFamily().regularText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 24,
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
                                    primary: ColorStyle().whiteColors,
                                  ),
                                  onPressed: () {
                                    final zommLink = session.zoomLink ?? '';
                                    _launchURL(zommLink);
                                  },
                                  icon: Icon(Icons.link),
                                  label: Text('Join Session',
                                      style: FontFamily().regularText.copyWith(
                                            color: ColorStyle().whiteColors,
                                          )),
                                ),
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
          );
        } else {
          return Center(child: Text('No data'));
        }
      },
    );
  }
}
