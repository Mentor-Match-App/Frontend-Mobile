import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/mentor/model/category_SMA_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';

class DetailMentorSMAScreen extends StatefulWidget {
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
  final MentorSMA mentor;

  const DetailMentorSMAScreen({
    Key? key,
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
    required this.mentor,
    required this.namakelas,
    required this.price, this.reviews,
  }) : super(key: key);

  @override
  State<DetailMentorSMAScreen> createState() => _DetailMentorSMAScreenState();
}

class _DetailMentorSMAScreenState extends State<DetailMentorSMAScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ProfileAvatar(
                      imageUrl: widget.photoUrl,
                      radius: 40,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: FontFamily().boldText,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.work_outline_outlined,
                                    size: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.job,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.location,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.home_work_outlined,
                                size: 16,
                                color: ColorStyle().primaryColors,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.company,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "About",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Text(
                  widget.about,
                  style: FontFamily().regularText,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: ColorStyle().primaryColors,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0), // Sesuaikan sesuai kebutuhan Anda
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            4.0), // Atur border radius menjadi 4
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.link, color: ColorStyle().whiteColors),
                    label: Text("linkedln", style: FontFamily().buttonText),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Skill",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: ColorStyle()
                              .primaryColors, // Warna garis atau border
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ), // Sesuaikan sesuai kebutuhan Anda
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          widget.skills[0],
                          style: FontFamily()
                              .buttonText
                              .copyWith(color: ColorStyle().secondaryColors),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: ColorStyle()
                              .primaryColors, // Warna garis atau border
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ), // Sesuaikan sesuai kebutuhan Anda
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          widget.skills[1] ?? "No Skill",
                          style: FontFamily()
                              .buttonText
                              .copyWith(color: ColorStyle().secondaryColors),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Experience",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                ExperienceWidget(
                    role: widget.mentor.experiences?.first.jobTitle ??
                        'No Job Title',
                    company: widget.mentor.experiences?.first.company ??
                        'No Company'),
                ExperienceWidget(
                    role: widget.mentor.experiences?.last.jobTitle ??
                        'No Job Title',
                    company: widget.mentor.experiences?.last.company ??
                        'No Company'),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.namakelas,
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Text(
                      widget.description,
                      style: FontFamily().regularText,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Syrarat & Ketentuan",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().primaryColors, fontSize: 16),
                    ),
                    Column(
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
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Review",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                ReviewWidget(
                  name: "Jhonson Alexa",
                  review: "Mentor yang sangat baik dan ramah",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
          Row(
            children: [
              SmallOutlinedButton(
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().primaryColors, fontSize: 12),
                height: 48,
                width: 152,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: "Cancel",
              ),
              const SizedBox(width: 8),
              SmallElevatedButton(
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().whiteColors, fontSize: 12),
                height: 48,
                width: 152,
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailBookingPremiumClass(),
                  //   ),
                  // );
                },
                title: "Booking",
              ),
            ],
          ),
        ],
      );
    },
  );
}
