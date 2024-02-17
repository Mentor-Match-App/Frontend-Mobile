import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/detail_mentor_karier_screen.dart';
import 'package:mentormatch_apps/mentee/service/service_Karier.dart';
import 'package:mentormatch_apps/mentor/model/category_Karier_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class SecurityEngineingKarierScreen extends StatefulWidget {
  SecurityEngineingKarierScreen({Key? key}) : super(key: key);

  @override
  State<SecurityEngineingKarierScreen> createState() =>
      _SecurityEngineingKarierScreenState();
}

class _SecurityEngineingKarierScreenState
    extends State<SecurityEngineingKarierScreen> {
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
          final mentorsWithLanguageCategory = snapshot.data!.mentors!
              .where((mentor) =>
                  mentor.mentorClass?.category == "Security Engineer")
              .toList();

             return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              childAspectRatio: 3 / 5, 
              crossAxisSpacing: 2,
              mainAxisSpacing: 2, 
            ),
            itemCount: mentorsWithLanguageCategory.length,
            itemBuilder: (context, index) {
              final mentor = mentorsWithLanguageCategory[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Menyediakan default Experience jika tidak ditemukan
              );
              final bool isClassAvailable = mentor.mentorClass?.isAvailable ??
                  false; // Default to false if null
                  final Color buttonColor = isClassAvailable
                  ? ColorStyle().primaryColors
                  : ColorStyle().disableColors;
              return CardItemMentor(
                  color:
                      buttonColor, // Use the determined color based on class availability
                  onPressesd: isClassAvailable
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMentorKarierScreen(
                                classid: mentor.mentorClass!.id ?? "",
                                periode:
                                    mentor.mentorClass?.durationInDays ?? 0,
                                reviews: mentor.mentorReviews ?? [],
                                namakelas: mentor.mentorClass?.name ?? "",
                                about: mentor.about ?? "",
                                name: mentor.name ?? "",
                                photoUrl: mentor.photoUrl ?? "",
                                job: mentor.experiences
                                        ?.firstWhere(
                                            (exp) => exp.isCurrentJob == true,
                                            orElse: () => Experience(
                                                jobTitle: "", company: ""))
                                        .jobTitle ??
                                    "",
                                company: mentor.experiences
                                        ?.firstWhere(
                                            (exp) => exp.isCurrentJob == true,
                                            orElse: () => Experience(
                                                jobTitle: "", company: ""))
                                        .company ??
                                    "",
                                email: mentor.email ?? "",
                                linkedin: mentor.linkedin ?? "",
                                skills: mentor.skills ?? [],
                                location: mentor.location ?? "",
                                description:
                                    mentor.mentorClass?.description ?? "",
                                terms: mentor.mentorClass?.terms ?? [],
                                price: mentor.mentorClass?.price ?? 0,
                                mentor: mentor,
                              ),
                            ),
                          );
                        }
                      : () => null,
                  imagePath: mentor.photoUrl.toString(),
                  name: mentor.name ?? 'No Name',
                  job: currentExperience.jobTitle ?? '',
                  company: currentExperience.company ?? 'Placeholder Company',
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
