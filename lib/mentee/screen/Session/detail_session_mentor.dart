// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_booking_session_screen.dart';
import 'package:mentormatch_apps/mentee/service/bookSessionService/bookSesion.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSessionsNew extends StatefulWidget {
  // final String sessionsid;
  final MentorSession detailmentor;
  final int availableSlots;
  final int totalParticipants;
  DetailMentorSessionsNew({
    Key? key,
    // required this.sessionsid,
    required this.totalParticipants,
    required this.availableSlots,
    required this.detailmentor,
  }) : super(key: key);
  @override
  State<DetailMentorSessionsNew> createState() =>
      _DetailMentorSessionsNewState();
}

class _DetailMentorSessionsNewState extends State<DetailMentorSessionsNew> {
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
    final mentorDetail = widget.detailmentor;

    // Ambil tanggal waktu pertama dari session (anda mungkin perlu mempertimbangkan bagaimana mengelola lebih dari satu sesi)
    DateTime? parsedJadwal;
    if (mentorDetail.session != null && mentorDetail.session!.isNotEmpty) {
      parsedJadwal = DateTime.parse(mentorDetail.session!.first.dateTime!);
    }
    final DateFormat formatOutput = DateFormat("HH:mm");
    final String formattedStartTime = formatOutput
        .format(DateTime.parse(mentorDetail.session!.first.startTime!));
    final String formattedEndTime = formatOutput
        .format(DateTime.parse(mentorDetail.session!.first.endTime!));
// Ubah format tanggal waktu ke format yang diinginkan
    String formattedJadwal = parsedJadwal != null
        ? DateFormat('dd MMMM yyyy').format(parsedJadwal)
        : "No scheduled session";

// Gunakan formattedJadwal sesuai kebutuhan Anda

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorStyle().tertiaryColors,
          title: AppBarLogoNotif()),
      body: ListView(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                        color: ColorStyle()
                            .tertiaryColors // Warna latar belakang yang diinginkan
                        ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0, -120 / 2.0),
                    child: Center(
                      child: Column(
                        children: [
                          ProfileAvatar(
                            imageUrl: widget.detailmentor.photoUrl,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.detailmentor.name.toString(),
                            style: FontFamily().boldText.copyWith(
                                  fontSize: 16,
                                ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: ColorStyle().primaryColors,
                            ),
                            label: Text(
                              widget.detailmentor.location ?? 'No Location',
                              style: FontFamily().regularText,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleProfile(
                                title: 'About',
                                color: ColorStyle().primaryColors,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  widget.detailmentor.about ?? 'No About',
                                  style: FontFamily().regularText,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12.0, top: 8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: ColorStyle().primaryColors,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: TextButton.icon(
                                      style: TextButton.styleFrom(
                                        primary: ColorStyle().whiteColors,
                                      ),
                                      onPressed: () {
                                        final linkedlnlink =
                                            widget.detailmentor.linkedin;
                                        _launchURL(linkedlnlink.toString());
                                      },
                                      icon: const Icon(Icons.link),
                                      label: Text('Linkedln',
                                          style: FontFamily()
                                              .regularText
                                              .copyWith(
                                                color: ColorStyle().whiteColors,
                                              )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleProfile(
                                title: 'Experience',
                                color: ColorStyle().primaryColors,
                              ),
                              Column(
                                children: widget.detailmentor.experiences
                                        ?.map((experience) {
                                      return ExperienceWidget(
                                        role: experience.jobTitle ??
                                            'No Job Title',
                                        company:
                                            experience.company ?? 'No Company',
                                      );
                                    }).toList() ??
                                    [const Text('No experiences')],
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TitleProfile(
                              title: 'Skills',
                              color: ColorStyle().primaryColors,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: widget.detailmentor.skills!
                                  .map((skill) => SkillCard(skill: skill))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            decoration: BoxDecoration(
                              color: ColorStyle().tertiaryColors,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(90),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24.0,
                                      left: 24,
                                      bottom: 12.0,
                                      right: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Jadwal Session",
                                          style: FontFamily()
                                              .titleText
                                              .copyWith(
                                                color:
                                                    ColorStyle().primaryColors,
                                              ),
                                        ),
                                      ),
                                      JadwalSessionWidget(
                                        icon: Icons.comment,
                                        title1: "topic",
                                        title2: widget.detailmentor.session!
                                                .first.title ??
                                            "No Topic",
                                      ),
                                      JadwalSessionWidget(
                                        icon: Icons.access_time_outlined,
                                        title1: "time",
                                        // title2: widget.jadwal + startTime + endTime,
                                        title2: formattedJadwal +
                                            " " +
                                            formattedStartTime +
                                            " - " +
                                            formattedEndTime,
                                      ),
                                      const JadwalSessionWidget(
                                          icon: Icons.location_on_outlined,
                                          title1: "location",
                                          title2: "Meeting Zoom"),
                                      JadwalSessionWidget(
                                          icon: Icons.people_alt_outlined,
                                          title1: "Total Participants",
                                          title2: widget.totalParticipants
                                              .toString()),
                                      JadwalSessionWidget(
                                        icon: Icons.chair_alt,
                                        title1: "Available Slots",
                                        title2:
                                            widget.availableSlots.toString(),
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButtonWidget(
                                        title: "Booking Session",
                                        onPressed: () {
                                          _showDialog(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// booking class ////
  void _showDialog(BuildContext context) {
    DateTime? parsedJadwal;
    if (widget.detailmentor.session != null &&
        widget.detailmentor.session!.isNotEmpty) {
      parsedJadwal =
          DateTime.parse(widget.detailmentor.session!.first.dateTime!);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: ColorStyle().whiteColors,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Booking Session", style: FontFamily().titleText),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_sharp,
                  color: ColorStyle().errorColors,
                ),
              )
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Apakah kamu yakin untuk memesan session ini? Kamu dapat memesan session ini secara gratis",
              textAlign: TextAlign.center,
              style: FontFamily().regularText,
            ),
          ),
          actions: <Widget>[
            SmallOutlinedButton(
              style: FontFamily()
                  .regularText
                  .copyWith(color: ColorStyle().primaryColors, fontSize: 12),
              height: 48,
              width: 100,
              onPressed: () => Navigator.of(context).pop(),
              title: "Cancel",
            ),
            SmallElevatedButton(
              style: FontFamily()
                  .regularText
                  .copyWith(color: ColorStyle().whiteColors, fontSize: 12),
              height: 48,
              width: 100,
              onPressed: () async {
                try {
                  String? userId = await UserPreferences.getUserId();
                  if (userId != null) {
                    var result = await bookSession(
                        widget.detailmentor.session!
                            .map((session) => session.id)
                            .join(","),
                        userId);
                    if (result.isSuccess) {
                      // Jika booking sukses, lakukan navigasi
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBookingSession(
                                  nama_mentor:
                                      widget.detailmentor.name.toString(),
                                  nama_session: widget.detailmentor.session!
                                      .map((session) => session.title)
                                      .join(", "),
                                  jadwal_session: parsedJadwal.toString(),
                                )),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      // Jika booking gagal, tampilkan pesan error
                      throw Exception(result.message);
                    }
                  } else {
                    throw Exception(
                        "Anda belum login, silahkan login terlebih dahulu.");
                  }
                } catch (e) {
                  showTopSnackBar(context, e.toString());
                }
              },
              title: "Booking",
            ),
          ],
        );
      },
    );
  }

  void showTopSnackBar(BuildContext context, String message) {
    Flushbar(
      backgroundColor: ColorStyle().secondaryColors,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: ColorStyle().whiteColors,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: ColorStyle().errorColors,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP, // Menampilkan di bagian atas
    ).show(context);
  }
}
