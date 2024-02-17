// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_booking_session_screen.dart';
import 'package:mentormatch_apps/mentee/service/bookSessions/bookSesion.dart';
import 'package:mentormatch_apps/mentee/service/bookSessions/save_booking_session.dart';
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
  final int availableSlots;
  final String sessionsid;
  final int participants;
  final String namaSessios;
  final String about;
  final String photoUrl;
  final String namaMentor;
  final String company;
  final String job;
  final String email;
  final String linkedin;
  final List<String> skills;
  final String location;
  final String description;
  final MentorSession mentor;
  final String jadwal;
  DetailMentorSessionsNew({
    Key? key,
    required this.namaSessios,
    required this.about,
    required this.photoUrl,
    required this.namaMentor,
    required this.company,
    required this.job,
    required this.email,
    required this.linkedin,
    required this.skills,
    required this.location,
    required this.description,
    required this.mentor,
    required this.jadwal,
    required this.participants,
    required this.sessionsid,
    required this.availableSlots,
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
    DateTime parsedJadwal = DateTime.parse(widget.jadwal);
    String formattedJadwal =
        DateFormat('dd MMMM yyyy HH:mm').format(parsedJadwal);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorStyle().tertiaryColors,
          title: AppBarLogoNotif()),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        imageUrl: widget.photoUrl,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.namaMentor,
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
                          widget.location,
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
                              widget.about,
                              style: FontFamily().regularText,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 12.0, top: 8.0),
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
                                    final linkedlnlink = widget.linkedin;
                                    _launchURL(linkedlnlink);
                                  },
                                  icon: const Icon(Icons.link),
                                  label: Text('Linkedln',
                                      style: FontFamily().regularText.copyWith(
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
                            children: widget.mentor.experiences
                                    ?.map((experience) {
                                  return ExperienceWidget(
                                    role: experience.jobTitle ?? 'No Job Title',
                                    company: experience.company ?? 'No Company',
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
                          children: widget.skills
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Jadwal Session",
                                      style: FontFamily().titleText.copyWith(
                                            color: ColorStyle().primaryColors,
                                          ),
                                    ),
                                  ),
                                  JadwalSessionWidget(
                                    icon: Icons.comment,
                                    title1: "topic",
                                    title2: widget.namaSessios,
                                  ),
                                  JadwalSessionWidget(
                                    icon: Icons.access_time_outlined,
                                    title1: "time",
                                    // title2: widget.jadwal,
                                    title2: formattedJadwal,
                                  ),
                                  const JadwalSessionWidget(
                                      icon: Icons.location_on_outlined,
                                      title1: "location",
                                      title2: "Meeting Zoom"),
                                  JadwalSessionWidget(
                                    icon: Icons.people_alt_outlined,
                                    title1: "Total Participants",
                                    title2: widget.participants.toString(),
                                  ),
                                  JadwalSessionWidget(
                                    icon: Icons.chair_alt,
                                    title1: "Available Slots",
                                    title2: widget.availableSlots.toString(),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButtonWidget(
                                    title: "Join Session",
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
    );
  }

  /// booking class ////
  void _showDialog(BuildContext context) {
    DateTime parsedJadwal = DateTime.parse(widget.jadwal);
    String formattedJadwal =
        DateFormat('dd MMMM yyyy HH:mm').format(parsedJadwal);
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
              "Apakah Kamu yakin untuk memesan Session ini?",
              textAlign: TextAlign.center,
              style: FontFamily().regularText,
            ),
          ),
          actions: <Widget>[
            // Actions untuk booking class...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallOutlinedButton(
                  style: FontFamily().regularText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 12),
                  height: 48,
                  width: 100,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
                      // Asumsikan UserPreferences.init() dan UserPreferences.getUserId() sudah benar
                      String? userId = await UserPreferences.getUserId();

                      if (userId != null) {
                        // Memanggil bookSession dan menangani respons di dalam try-catch
                        await bookSession(widget.sessionsid, userId);

                        // Simpan data booking ke history
                        await saveBookingData(
                            widget.namaSessios,
                            widget.namaMentor,
                            formattedJadwal); // Pastikan ini sesuai dengan definisi fungsi saveBookingData Anda

                        // Jika tidak ada error yang dilempar, asumsikan booking berhasil
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBookingSession(
                                nama_session: widget.namaSessios,
                                nama_mentor: widget.namaMentor,
                                jadwal_session: formattedJadwal),
                          ),
                        );
                      } else {
                        // Tampilkan pesan error jika user belum login
                        throw Exception(
                            "Anda belum login, silahkan login terlebih dahulu");
                      }
                    } catch (e) {
                      print("Error: ${e.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: ${e.toString()}"),
                          backgroundColor: ColorStyle().errorColors,
                        ),
                      );
                    }
                  },
                  title: "Booking",
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
