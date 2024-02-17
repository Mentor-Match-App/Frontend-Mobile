import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/mentee/screen/MyClassMentee/MyClass_list_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/home_screen_mentee.dart';
import 'package:mentormatch_apps/mentee/service/bookSessions/ui_savebook.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class DetailBookingSession extends StatefulWidget {
  final String nama_mentor;
  final String jadwal_session;
  final String nama_session;

  DetailBookingSession({
    Key? key,
    required this.nama_mentor,
    required this.nama_session,
    required this.jadwal_session,
  }) : super(key: key);

  @override
  State<DetailBookingSession> createState() => _DetailBookingSessionState();
}

class _DetailBookingSessionState extends State<DetailBookingSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, left: 24.0, right: 8.0, bottom: 24.0),
                  child: Text(
                    "Payment Class",
                    style: FontFamily().boldText.copyWith(
                        fontSize: 24, color: ColorStyle().secondaryColors),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: ColorStyle().tertiaryColors,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        left: 24,
                        bottom: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Nama Session",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(widget.nama_session,
                              style: FontFamily().regularText),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Nama Mentor",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(widget.nama_mentor,
                              style: FontFamily().regularText),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Text(
                              "Jadwal Session",
                              style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 14),
                            ),
                          ),
                          Text(widget.jadwal_session.toString(),
                              style: FontFamily().regularText),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Link zoom akan kamu dapatkan ketika jadwal session dimulai.",
                            style: FontFamily()
                                .regularText
                                .copyWith(color: ColorStyle().errorColors),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 16.0),
                            child: ElevatedButtonWidget(
                              title: "Kembali Ke Beranda",
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingHistoryScreen()),
                                  (Route<dynamic> route) =>
                                      false, // Remove all routes until the new route
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
