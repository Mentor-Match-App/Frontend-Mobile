import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/home_mentee_screen.dart';
import 'package:mentormatch_apps/login-register/first_screen.dart';
import 'package:mentormatch_apps/mentor/model/category_SD_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';

class DetailMentorSession extends StatefulWidget {
  DetailMentorSession(
      {Key? key,
      required String about,
      required String name,
      required String photoUrl,
      required String job,
      required String company,
      required String email,
      required String linkedin,
      required List<String> skills,
      required String location,
      required String description,
      required List<String> terms,
      required MentorSD mentor})
      : super(key: key);

  @override
  State<DetailMentorSession> createState() => _DetailMentorSessionState();
}

class _DetailMentorSessionState extends State<DetailMentorSession> {
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
                      imageUrl: 'assets/Handoff/ilustrator/profile.png',
                      radius: 40,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Charline June",
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
                                  const Text(
                                    "UI/UX Designer",
                                    style: TextStyle(fontSize: 10),
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
                                  const Text(
                                    "Jakarta Selatan",
                                    style: TextStyle(fontSize: 10),
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
                              const Text(
                                "PT. Sinar Terus",
                                style: TextStyle(fontSize: 10),
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
                  'Experienced in business strategy, startup development, and leadership. Specialized expertise in building mobile applications.',
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
                          "Java Script",
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
                          "Flutter/Dart",
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
                    role: "Full Stack Developer", company: "Alaska"),
                ExperienceWidget(
                    role: "Full Stack Developer", company: "Alaska"),
                const Divider(),
                Text(
                  "Jadwal Sessions",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    textAlign: TextAlign.center,
                    '\" Mastering Modern Web Development with Node.js and React \"',
                    style: FontFamily().boldText.copyWith(
                        color: ColorStyle().secondaryColors, fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: ColorStyle().primaryColors,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Senin, 20 September 2021",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().secondaryColors, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: ColorStyle().primaryColors,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "15/100 Peserta",
                      style: FontFamily().boldText.copyWith(
                          color: ColorStyle().secondaryColors, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                ElevatedButtonWidget(
                  title: "Booking Sessions",
                  onPressed: () {
                    _showDialog(context);
                  },
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
            "Apakah Kamu yakin untuk memesan Session ini?",
            textAlign: TextAlign.center,
            style: FontFamily().regularText,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallOutlinedButton(
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().primaryColors, fontSize: 12),
                height: 36,
                width: 100,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: "Cancel",
              ),
              SizedBox(width: 8),
              SmallElevatedButton(
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().whiteColors, fontSize: 12),
                height: 36,
                width: 100,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeMenteeScreen(),
                    ),
                  );
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
