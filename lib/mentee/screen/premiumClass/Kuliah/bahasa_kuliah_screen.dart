import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Kuliah/detail_mentor_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/service/service_Kuliah.dart';
import 'package:mentormatch_apps/mentor/model/category_Kuliah_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class BahasaKuliahScreen extends StatefulWidget {
  BahasaKuliahScreen({Key? key}) : super(key: key);

  @override
  State<BahasaKuliahScreen> createState() => _BahasaKuliahScreenState();
}

class _BahasaKuliahScreenState extends State<BahasaKuliahScreen> {
late Future<Kuliah> futureKuliahData;

  @override
  void initState() {
    super.initState();
    futureKuliahData = KuliahServices().getKuliahData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Kuliah>(
      future: futureKuliahData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final mentorsWithLanguageCategory = snapshot.data!.mentors!
              .where((mentor) => mentor.mentorClass?.category == "Bahasa")
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
                              builder: (context) => DetailMentorKuliahScreen(
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
