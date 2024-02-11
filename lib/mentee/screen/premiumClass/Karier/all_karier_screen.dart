import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/detail_mentor_karier_screen.dart';
import 'package:mentormatch_apps/mentee/service/service_Karier.dart';
import 'package:mentormatch_apps/mentor/model/category_Karier_model.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllKarierScreen extends StatefulWidget {
  AllKarierScreen({Key? key}) : super(key: key);

  @override
  State<AllKarierScreen> createState() => _AllKarierScreenState();
}

class _AllKarierScreenState extends State<AllKarierScreen> {
  late Future<Karier> futureKarierData;

  @override
  void initState() {
    super.initState();
    futureKarierData = KarierServices().getKarierData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Karier>(
      future: futureKarierData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final mentors = snapshot.data!.mentors!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              final mentor = mentors[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Menyediakan default Experience jika tidak ditemukan
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemMentor(
                  imagePath: mentor.photoUrl ??
                      'assets/Handoff/ilustrator/profile.png',
                  name: mentor.name ?? 'No Name',
                  job: currentExperience.jobTitle ?? '',
                  company: currentExperience.company ?? 'Placeholder Company',
                   onPressesd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorKarierScreen(
                          reviews: mentor.mentorReviews ?? [],
                          namakelas: mentor.mentorClass?.name ?? "",
                          about: mentor.about ?? "",
                          name: mentor.name ?? "",
                          photoUrl: mentor.photoUrl ?? "",
                          job: mentor.experiences
                                  ?.firstWhere(
                                      (exp) => exp.isCurrentJob == true,
                                      orElse: () =>
                                          Experience(jobTitle: "", company: ""))
                                  .jobTitle ??
                              "",
                          company: mentor.experiences
                                  ?.firstWhere(
                                      (exp) => exp.isCurrentJob == true,
                                      orElse: () =>
                                          Experience(jobTitle: "", company: ""))
                                  .company ??
                              "",
                          email: mentor.email ?? "",
                          linkedin: mentor.linkedin ?? "",
                          skills: mentor.skills ?? [],
                          location: mentor.location ?? "",
                          description: mentor.mentorClass?.description ?? "",
                          terms: mentor.mentorClass?.terms ?? [],
                          price: mentor.mentorClass?.price ?? 0,
                          mentor: mentor,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            shrinkWrap: true,
            physics:
                ScrollPhysics(), // Mengizinkan scroll jika di dalam SingleChildScrollView
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
