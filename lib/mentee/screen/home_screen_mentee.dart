import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/screen/detail_mentor_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/Karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/all_karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Kuliah/Kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMP/SMP_screen.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/mentor_model.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/mentor/service/mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class HomeMenteeScreen extends StatefulWidget {
  HomeMenteeScreen({Key? key}) : super(key: key);

  @override
  State<HomeMenteeScreen> createState() => _HomeMenteeScreenState();
}

class _HomeMenteeScreenState extends State<HomeMenteeScreen> {
  late Future<List<dynamic>> _futureData;

  // Membuat instance dari kedua service
  final SessionServices _sessionServices = SessionServices();
  final MentorService _mentorService = MentorService();

  @override
  void initState() {
    super.initState();
    _futureData = Future.wait([
      _sessionServices.getSessionData(),
      _mentorService.fetchFilteredMentors(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarHomePage()),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data'));
          } else {
            var mentorSessionData = snapshot.data![0] as Session;
            var mentorClassData = snapshot.data![1] as MentorClassModel;

            return CustomScrollView(slivers: <Widget>[
              // Replace the SliverPadding and SliverGrid with the following:
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 0.0, bottom: 16.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Find Your Mentor",
                        style: FontFamily().boldText.copyWith(
                              color: ColorStyle().secondaryColors,
                              fontSize: 14,
                            ),
                      ),
                      SearchBarWidget(title: "Search Mentor"),
                      const SizedBox(height: 8.0),
                      TittleTextField(
                        title: "Premium Class",
                        color: ColorStyle().secondaryColors,
                      ),
                      Text(
                        "Temukan mentor yang sesuai dengan tingkat pendidikan kamu",
                        style: FontFamily().regularText.copyWith(
                              color: ColorStyle().disableColors,
                              fontSize: 12,
                            ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis
                            .horizontal, // Mengatur pengguliran ke arah horizontal
                        child: Row(
                          children: [
                            ButtonEducationLevels(
                              title: "SD",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SDScreen(),
                                  ),
                                );
                              },
                            ),
                            ButtonEducationLevels(
                              title: "SMP",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SMPScreen()));
                              },
                            ),
                            ButtonEducationLevels(
                              title: "SMA",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SMAScreen()));
                              },
                            ),
                            ButtonEducationLevels(
                              title: "Kuliah",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KuliahScreen(),
                                  ),
                                );
                              },
                            ),
                            ButtonEducationLevels(
                              title: "Karier",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KarierScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TittleTextField(
                            title: "Mentor Premium",
                            color: ColorStyle().secondaryColors,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height:
                            250, // Adjust the height according to your design
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                mentorSessionData.mentors!.length, (index) {
                              final mentor = mentorClassData.mentors![index];
                              ExperienceClassAll? currentJob =
                                  mentor.experiences?.firstWhere(
                                (exp) => exp.isCurrentJob ?? false,
                                orElse: () => ExperienceClassAll(),
                              );

                              String company =
                                  currentJob?.company ?? 'Placeholder Company';
                              String jobTitle =
                                  currentJob?.jobTitle ?? 'Placeholder Job';

                              return Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                height: 250,
                                width: 150,
                                child: CardItemMentor(
                                  // color:
                                  //     buttonColor, // Use the determined color based on class availability
                                  onPressesd: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailMentorClassAllScreen(
                                              reviews: mentor.mentorReviews ?? [],
                                          experiences: mentor.experiences ?? [],
                                          email: mentor.email ?? '',
                                          classes: mentor.mentorClass ?? [],
                                          about: mentor.about ?? '',
                                          name: mentor.name ?? 'No Name',
                                          photoUrl: mentor.photoUrl ?? '',
                                          skills: mentor.skills ?? [],
                                          classid: mentor.id.toString(),
                                          company: company,
                                          job: jobTitle,
                                          linkedin: mentor.linkedin ?? '',
                                          mentor: mentor,
                                          location: mentor.location ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath: mentor.photoUrl.toString(),
                                  name: mentor.name ?? 'No Name',
                                  job: jobTitle,
                                  company: company,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TittleTextField(
                            title: "Mentor Session",
                            color: ColorStyle().secondaryColors,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height:
                            250, // Adjust the height according to your design
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                mentorSessionData.mentors!.length, (index) {
                              final mentor = mentorSessionData.mentors![index];
                              final currentExperience =
                                  mentor.experiences!.firstWhere(
                                (experience) =>
                                    experience.isCurrentJob ?? false,
                                orElse: () =>
                                    Experience(), // Menyediakan default Experience jika tidak ditemukan
                              );
                              ////// session active///////

                              var firstActiveSession =
                                  mentor.session?.firstWhere(
                                (s) => s.isActive == true,
                                orElse: () =>
                                    SessionElement(), // Provide a default session element if no active session is found
                              );
                              ////// session full///////
                              var isSessionFull = (firstActiveSession
                                          ?.participant?.length ??
                                      0) >=
                                  (firstActiveSession?.maxParticipants ?? 0);
                              var numberOfParticipants =
                                  firstActiveSession!.participant?.length ?? 0;
                              ////// name session///////
                              var activeSessionName =
                                  firstActiveSession.title ??
                                      "No active session";
                              ////// date time session///////
                              var activeSessionDateTime =
                                  firstActiveSession.dateTime ??
                                      "No date/time provided";
                              ////// description session///////
                              var activeSessionDescription =
                                  firstActiveSession.description ??
                                      "No description provided";
                              ////// button color is full //////
                              final Color buttonColor = isSessionFull
                                  ? ColorStyle().disableColors
                                  : ColorStyle().primaryColors;
                              ////// slot///////
                              SessionElement sessionElement =
                                  mentor.session!.first;
                              int maxParticipants =
                                  sessionElement.maxParticipants ?? 0;
                              int currentParticipants =
                                  sessionElement.participant?.length ?? 0;
                              int availableSlots =
                                  maxParticipants - currentParticipants;
                              return Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                height: 250,
                                width: 150,
                                child: CardItemMentor(
                                  color: buttonColor,
                                  onPressesd: isSessionFull
                                      ? () {}
                                      : () {
                                          // Logika untuk navigasi ketika sesi belum penuh
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailMentorSessionsNew(
                                                availableSlots: availableSlots,
                                                sessionsid: mentor.session!
                                                        .firstWhere((s) =>
                                                            s.isActive == true)
                                                        .id ??
                                                    "",

                                                participants:
                                                    numberOfParticipants,
                                                about: mentor.about ?? "",
                                                namaMentor: mentor.name ?? "",
                                                photoUrl: mentor.photoUrl ?? "",
                                                job: mentor.experiences
                                                        ?.firstWhere(
                                                          (exp) =>
                                                              exp.isCurrentJob ==
                                                              true,
                                                          orElse: () =>
                                                              Experience(
                                                                  jobTitle: "",
                                                                  company: ""),
                                                        )
                                                        .jobTitle ??
                                                    "",
                                                company: mentor.experiences
                                                        ?.firstWhere(
                                                          (exp) =>
                                                              exp.isCurrentJob ==
                                                              true,
                                                          orElse: () =>
                                                              Experience(
                                                                  jobTitle: "",
                                                                  company: ""),
                                                        )
                                                        .company ??
                                                    "",
                                                email: mentor.email ?? "",
                                                linkedin: mentor.linkedin ?? "",
                                                skills: mentor.skills ?? [],
                                                location: mentor.location ?? "",
                                                mentor: mentor,
                                                namaSessios:
                                                    activeSessionName, // Session name
                                                jadwal:
                                                    activeSessionDateTime, // Session date/time
                                                description:
                                                    activeSessionDescription, // Session description
                                              ),
                                            ),
                                          );
                                        },
                                  imagePath: mentor.photoUrl ??
                                      'assets/Handoff/ilustrator/profile.png',
                                  name: mentor.name ?? 'No Name',
                                  job: currentExperience.jobTitle ?? '',
                                  company: currentExperience.company ??
                                      'Placeholder Company',
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]);
          }
        },
      ),
    );
  }
}
