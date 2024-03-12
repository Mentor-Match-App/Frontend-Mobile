import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/Karier/detail_mentor_karier_screen.dart';
import 'package:mentormatch_apps/mentee/service/service_Karier.dart';
import 'package:mentormatch_apps/mentor/model/category_Karier_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class DesignKarierScreen extends StatefulWidget {
  DesignKarierScreen({Key? key}) : super(key: key);

  @override
  State<DesignKarierScreen> createState() => _DesignKarierScreenState();
}

class _DesignKarierScreenState extends State<DesignKarierScreen> {
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
              .where((mentor) => mentor.mentorClass!
                  .any((mentorClass) => mentorClass.category == 'Desain'))
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
              ExperienceKarier? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceKarier(),
              );

                    /// if all class is active ///
              bool areAllClassesActive(List<ClassMentorKarier>? classes) {
                if (classes == null || classes.isEmpty) {
                  return false;
                }
                // Mengembalikan true jika semua kelas memiliki isActive == true
                return classes
                    .every((classMentor) => classMentor.isActive == true);
              }

              bool allClassesActive = areAllClassesActive(mentor.mentorClass);
              Color buttonColor = allClassesActive
                  ? ColorStyle().disableColors
                  : ColorStyle().primaryColors;
              String company = currentJob?.company ?? 'Placeholder Company';
              String jobTitle = currentJob?.jobTitle ?? 'Placeholder Job';
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemMentor(
                  color:
                      buttonColor,
                  onPressesd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorKarierScreen(
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