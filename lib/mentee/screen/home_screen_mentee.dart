import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/screen/session/session_screen.dart';
import 'package:mentormatch_apps/mentee/screen/detail_mentor_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/Karier/Karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/Kuliah/Kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/SD/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/SMA/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/SMP/SMP_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/premium_class_screen.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _futureData = Future.wait([
      _sessionServices.getSessionData(),
      _mentorService.fetchFilteredMentors(),
    ]);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
            // mentor session yang di tampilkan hanya yang isActive == true
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
                      SearchBarWidget(
                          controller: searchController,
                          title: "Search Mentor",
                          onPressed: () {
                            // searchMentor(searchController.text);
                          }),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PremiumClassScreen(),
                                ),
                              );
                            },
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
                                ////yang ditampilkan hanya 6 aja
                                mentorClassData.mentors!.length > 6
                                    ? 6
                                    : mentorClassData.mentors!.length, (index) {
                              final mentor = mentorClassData.mentors![index];
                              ExperienceClassAll? currentJob =
                                  mentor.experiences?.firstWhere(
                                (exp) => exp.isCurrentJob ?? false,
                                orElse: () => ExperienceClassAll(),
                              );
                              // Fungsi untuk mendapatkan slot yang tersedia
                              int getAvailableSlotCount(ClassAll kelas) {
                                int approvedCount = kelas.transactions
                                        ?.where((t) =>
                                            t.paymentStatus == "Approved")
                                        .length ??
                                    0;

                                int pendingCount = kelas.transactions
                                        ?.where(
                                            (t) => t.paymentStatus == "Pending")
                                        .length ??
                                    0;

                                int totalApprovedAndPendingCount =
                                    approvedCount + pendingCount;

                                // Jumlah slot yang tersedia adalah maksimum partisipan dikurangi dengan total transaksi yang telah disetujui dan sedang diproses
                                int availableSlots =
                                    (kelas.maxParticipants ?? 0) -
                                        totalApprovedAndPendingCount;
                                // Pastikan slot yang tersedia tidak negatif
                                return availableSlots > 0 ? availableSlots : 0;
                              }

// Fungsi untuk menentukan apakah semua kelas dalam daftar mentor dianggap penuh
                              bool allClassesFull =
                                  mentor.mentorClass!.every((classMentor) {
                                int availableSlotCount =
                                    getAvailableSlotCount(classMentor);
                                return availableSlotCount <= 0;
                              });

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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SessionScreen(),
                                ),
                              );
                            },
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
                              mentorSessionData.mentors!
                                          .where((mentor) => mentor.session!
                                              .any((session) =>
                                                  session.isActive == true))
                                          .length >
                                      6
                                  ? 6
                                  : mentorSessionData.mentors!
                                      .where((mentor) => mentor.session!.any(
                                          (session) =>
                                              session.isActive == true))
                                      .length,
                              (index) {
                                final mentor = mentorSessionData.mentors!
                                    .where((mentor) => mentor.session!.any(
                                        (session) => session.isActive == true))
                                    .toList()[index];

                                final currentExperience =
                                    mentor.experiences!.firstWhere(
                                  (experience) =>
                                      experience.isCurrentJob ?? false,
                                  orElse: () =>
                                      Experience(), // Menyediakan default Experience jika tidak ditemukan
                                );

                                //buat session active ketika isActive = true
                                final activeSessions = mentor.session!
                                    .where((s) => s.isActive == true)
                                    .toList();
                                //// buat session full apabila jumlah participant sudah mencapai maxParticipants
                                final isSessionFull =
                                    activeSessions.isNotEmpty &&
                                        activeSessions.any((session) =>
                                            session.participant!.length >=
                                            session.maxParticipants!);

                                ///numberOfParticipants = jumlah participant yang sudah join
                                final numberOfParticipants = activeSessions
                                        .isNotEmpty
                                    ? activeSessions.first.participant!.length
                                    : 0;
                                ////// button color is full //////
                                final Color buttonColor = isSessionFull
                                    ? ColorStyle().disableColors
                                    : ColorStyle().primaryColors;
                                ////// slot///////
                                SessionData sessionElement =
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
                                    // apabila session penuh maka tiitlenya " session full" , tetapi apabila tidak full maka " available"
                                    title: isSessionFull
                                        ? "Full Booked"
                                        : "Available",
                                    color: buttonColor,
                                    onPressesd: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMentorSessionsNew(
                                            availableSlots: availableSlots,
                                            detailmentor: mentor,
                                            totalParticipants:
                                                numberOfParticipants,
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
                              },
                            ),
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
