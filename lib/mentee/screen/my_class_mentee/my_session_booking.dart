import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentor/service/my_class_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionBooking extends StatefulWidget {
  @override
  _MySessionBookingState createState() => _MySessionBookingState();
}

class _MySessionBookingState extends State<MySessionBooking> {
  Future<List<ParticipantMyClass>>? _userData;

  int _getPriority(SessionMyClass userSessions) {
    String buttonText = "Available";
    // buttonCollor scheduled ketika isActive bernilai true + startTimenya belum mulai
    if (userSessions.isActive == true &&
        DateTime.parse(userSessions.startTime!).isAfter(DateTime.now())) {
      buttonText = "Scheduled";
    } else if (userSessions.isActive == false &&
        DateTime.now().isBefore(DateTime.parse(userSessions.endTime!))) {
      buttonText = "Active";
    } else if (userSessions.isActive == false &&
        DateTime.now().isAfter(DateTime.parse(userSessions.endTime!))) {
      buttonText = "Finished";
    }

    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
    if (buttonText == "Active") {
      return 1;
    } else if (buttonText == "Scheduled") {
      return 2;
    } else if (buttonText == "Finished") {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserSessions();

    _userData!.then((value) {
      value.sort((a, b) {
        return _getPriority(a.session!).compareTo(_getPriority(b.session!));
      });
    });
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
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final List<ParticipantMyClass> participants = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: participants.map((participant) {
                final session = participant.session!;
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
                          if (statusButton == 1)
                            createStatusButton(
                                "Active", ColorStyle().succesColors)
                          else if (statusButton == 2)
                            createStatusButton(
                                "Scheduled", ColorStyle().secondaryColors)
                          else if (statusButton == 3)
                            createStatusButton(
                                "Finished", ColorStyle().disableColors),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                  child: CachedNetworkImage(
                                imageUrl: session.mentor!.photoUrl.toString(),
                                fit: BoxFit.cover,
                                width: 98,
                                height: 98,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )),
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
                                      'Jam : ${formattedStartTime} - ${formattedEndTime}',
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
          return Container(
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
