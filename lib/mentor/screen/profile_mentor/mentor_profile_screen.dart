import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/profile_mentor/service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/profile_model.dart';

class MentorProfileScreen extends StatefulWidget {
  const MentorProfileScreen({super.key});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  final ProfileService mentorService = ProfileService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorStyle().tertiaryColors,
          title: AppBarLogoNotif()),
      body: FutureBuilder<MentorProfile>(
        future: mentorService
            .getMentorProfile(), // Call the asynchronous fetchMentee method here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final mentor = snapshot.data;

            return ListView(
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
                              imageUrl: mentor!.user?.photoUrl,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "David Wilson",
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
                                "Jakarta",
                                style: FontFamily().regularText,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleProfile(
                                  title: "About",
                                  color: ColorStyle().primaryColors,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    mentor.user?.about ?? '',
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
                                              mentor?.user!.linkedin ?? '';
                                          _launchURL(linkedlnlink);
                                        },
                                        icon: Icon(Icons.link),
                                        label: Text('Linkedln',
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                  color:
                                                      ColorStyle().whiteColors,
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
                                  children: mentor?.user!.experiences
                                          ?.map((experience) {
                                        return ExperienceWidget(
                                          role: experience.jobTitle ??
                                              'No Job Title',
                                          company: experience.company ??
                                              'No Company',
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
                                  children: mentor?.user!.skills
                                          ?.map((skill) => SkillCard(
                                                skill: skill,
                                              ))
                                          .toList() ??
                                      [Text('No skills')]),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
