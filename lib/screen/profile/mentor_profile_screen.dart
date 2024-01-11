import 'package:flutter/material.dart';
import 'package:mentormatch_apps/screen/login-register/edit_profile.dart';
import 'package:mentormatch_apps/screen/login-register/first_screen.dart';
import 'package:mentormatch_apps/screen/notification_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';

class MentorProfileScreen extends StatefulWidget {
  MentorProfileScreen({Key? key}) : super(key: key);

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/Handoff/logo/LogoMobile.png'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              icon: Icon(Icons.notifications_none_outlined),
              color: ColorStyle().secondaryColors,
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Steven Jobs",
                                style: FontFamily().boldText,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeProfileScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 16,
                                  color: ColorStyle().primaryColors,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.work_outline_outlined,
                                    size: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "UI/UX Designer",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
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
                              SizedBox(width: 4),
                              Text(
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
                      padding: EdgeInsets.symmetric(
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
                SizedBox(height: 12),
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
                          padding: EdgeInsets.symmetric(
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
                    SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: ColorStyle()
                              .primaryColors, // Warna garis atau border
                          padding: EdgeInsets.symmetric(
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
                SizedBox(height: 12),
                Text(
                  "Experience",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                ExperienceWidget(
                    role: "Full Stack Developer", company: "Alaska"),
                ExperienceWidget(
                    role: "Full Stack Developer", company: "Alaska"),
                ButtonDetailKegiatan(
                  firstText: "IDR 1.000.000,00",
                  secondText: "Rincian Keiatan",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstScreen(),
                      ),
                    );
                  },
                ),
                Text(
                  "Review",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                ReviewWidget(
                    name: "Jhonson Alexa",
                    review:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat !!!"),
                ReviewWidget(
                    name: "Jhonson Alexa",
                    review:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat !!!"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
