import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/profile_model.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/edit_profile_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMenteeScreen extends StatefulWidget {
  ProfileMenteeScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMenteeScreen> createState() => _ProfileMenteeScreenState();
}

class _ProfileMenteeScreenState extends State<ProfileMenteeScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  void initState() {
    super.initState();
    // Contoh memanggil fungsi load data di sini, sehingga setiap kali kembali ke halaman ini, data terbaru akan dimuat
    _loadData();
  }

  void _loadData() async {
    final profileData = await menteeService.getMenteeProfile();
    setState(() {
      // Update your state with the new profile data
    });
  }

  void _navigateToEditProfile() async {
    final mentor = await menteeService
        .getMenteeProfile(); // Assuming you fetch the mentor profile here

    if (!mounted) return; // Check if the widget is still in the widget tree

    if (mentor != null && mentor.user != null) {
      List<Map<String, String>> experiencesMaps = mentor.user!.experiences!
          .where((experience) =>
              experience.isCurrentJob ==
              false) // Filter experiences where isCurrentJob is false
          .map((experience) => {
                "jobTitle": experience.jobTitle ?? '',

                "company": experience.company ?? '',
                // Add other fields as necessary
              })
          .toList();

      // Navigate to EditProfileMentorScreen with the converted experiences
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileMenteeScreen(
            linkedin: mentor.user!.linkedin ?? '',
            about: mentor.user!.about ?? '',
            location: mentor.user!.location ?? '',
            currentJob: mentor.user!.experiences
                    ?.firstWhere((element) => element.isCurrentJob == true,
                        orElse: () => Experience())
                    .jobTitle ??
                '',
            currentCompany: mentor.user!.experiences
                    ?.firstWhere((element) => element.isCurrentJob == true,
                        orElse: () => Experience())
                    .company ??
                '',
            experiences: experiencesMaps,
            skills: mentor.user!.skills ?? [],
          ),
        ),
      );
    }
  }

  final ProfileService menteeService = ProfileService();
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
                    builder: (context) => NotificationMenteeScreen(),
                  ),
                );
              },
              icon: Icon(Icons.notifications_none_outlined),
              color: ColorStyle().secondaryColors,
            )
          ],
        ),
      ),
      body: FutureBuilder<MenteeProfile>(
        future: menteeService
            .getMenteeProfile(), // Call the asynchronous fetchMentee method here
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
            final mentee = snapshot.data;

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
                              imageUrl: mentee?.user!.photoUrl ?? '',
                            ),
                            SizedBox(
                              height:
                                  40, // Adjust the height to ensure enough space for the Stack
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      mentee!.user?.name ?? '',
                                      style: FontFamily().boldText.copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      top:
                                          0, // Adjust as needed to position the edit icon correctly
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: _navigateToEditProfile,
                                      )),
                                ],
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // This ensures the Row only takes up necessary space
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Provides a small gap between the icon and the text
                                  Text(
                                    "${mentee.user?.experiences?.firstWhere((element) => element.isCurrentJob == true).jobTitle ?? ""} at ${mentee.user?.experiences?.firstWhere((element) => element.isCurrentJob == true).company ?? ""}",
                                    style: FontFamily().regularText,
                                  ),
                                ],
                              ),
                            ),

// For Location Information Row
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // This ensures the Row only takes up necessary space
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Provides a small gap between the icon and the text
                                  Text(
                                    mentee.user?.location ?? '',
                                    style: FontFamily().regularText,
                                  ),
                                ],
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
                                    mentee.user?.about ?? '',
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
                                              mentee?.user!.linkedin ?? '';
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
                                  children: mentee.user!.experiences
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
                                  children: mentee.user!.skills
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
