import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/service/bookingClass/bookclass_service.dart';
import 'package:mentormatch_apps/mentee/service/bookingClass/bookclass_model.dart';
import 'package:mentormatch_apps/mentor/model/category_SD_model.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSDScreen extends StatefulWidget {
  final String classid;
  final int periode;
  final List<MentorReview>? reviews;
  final int price;
  final String namakelas;
  final String about;
  final String photoUrl;
  final String name;
  final String company;
  final String job;
  final String email;
  final String linkedin;
  final List<String> skills;
  final String location;
  final String description;
  final List<String> terms;
  final MentorSD mentor;
  DetailMentorSDScreen(
      {Key? key,
      required this.classid,
      required this.periode,
      this.reviews,
      required this.price,
      required this.namakelas,
      required this.about,
      required this.photoUrl,
      required this.name,
      required this.company,
      required this.job,
      required this.email,
      required this.linkedin,
      required this.skills,
      required this.location,
      required this.description,
      required this.terms,
      required this.mentor})
      : super(key: key);

  @override
  State<DetailMentorSDScreen> createState() => _DetailMentorSDScreenState();
}

class _DetailMentorSDScreenState extends State<DetailMentorSDScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorStyle().tertiaryColors,
          title: AppBarLogoNotif()),
      body:
       ListView(
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
                offset: Offset(0.0, -120 / 2.0),
                child: Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        imageUrl: widget.photoUrl,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.name,
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
                                    final linkedlnlink = widget.linkedin ?? '';
                                    _launchURL(linkedlnlink);
                                  },
                                  icon: Icon(Icons.link),
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
                                [Text('No experiences')],
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: widget.namakelas,
                            color: ColorStyle().primaryColors,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              widget.description,
                              style: FontFamily().regularText,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: 'Syarat & Ketentuan Kelas',
                            color: ColorStyle().primaryColors,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.mentor.mentorClass?.terms
                                      ?.asMap()
                                      .entries
                                      .map<Widget>((entry) {
                                    int index = entry.key;
                                    String term = entry.value;
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom:
                                              8.0), // Tambahkan sedikit ruang antar baris
                                      child: Text(
                                        "${index + 1}.  $term", // Menambahkan indeks + 1 untuk membuat nomor urutan dimulai dari 1
                                        style: FontFamily().regularText,
                                      ),
                                    );
                                  }).toList() ??
                                  [
                                    Text("No terms available",
                                        style: FontFamily().regularText)
                                  ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonWidget(
                          onPressed: () {
                            _showDialog(context);
                          },
                          title:
                              "${NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.price)}",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Review',
                          color: ColorStyle().primaryColors,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildReviewWidgets(),
                      ),
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

  //////review mentor///////
  Widget buildReviewWidgets() {
    // Periksa apakah reviews ada dan tidak kosong
    if (widget.reviews != null && widget.reviews!.isNotEmpty) {
      return Column(
        children: widget.reviews!.map((review) {
          return ReviewWidget(
            name: review.reviewer ?? "No Name",
            review: review.content ?? "No Review",
          );
        }).toList(),
      );
    } else {
      // Jika tidak ada review, tampilkan pesan
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Belum ada review",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }
  }

  ///// booking class ////
  void _showDialog(BuildContext context) {
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
              Text("Booking Class", style: FontFamily().titleText),
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
              "Apakah Kamu yakin untuk memesan Premium Class ini?",
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
                      // Initialize UserPreferences if not already done.
                      await UserPreferences.init();

                      // Retrieve the user ID from SharedPreferences
                      String? userId = UserPreferences.getUserId();

                      if (userId != null) {
                        BookingResultSession result =
                            await bookClass(widget.classid, userId);

                        if (result.isSuccess) {
                          // If booking succeeds, navigate to the next screen
                          int? uniqueCode =
                              result.uniqueCode; // Here you get the uniqueCode
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailBookingClass(
                                price: widget.price,
                                nama_mentor: widget.name,
                                nama_kelas: widget.namakelas,
                                durasi: widget.periode,
                                uniqueCode: uniqueCode!,
                              ),
                            ),
                          );
                        } else {
                          // If booking fails, show an error message
                          throw Exception("tidak bisa booking kelas ini");
                        }
                      } else {
                        // If userId is not found, show an error
                        throw Exception(
                            "Anda belum login, silahkan login terlebih dahulu");
                      }
                    } catch (e) {
                      // Show a SnackBar if an exception occurs
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
