import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMP/detail_mentor_SMP_screen.dart';
import 'package:mentormatch_apps/mentee/service/service_SMP_mentor.dart';
import 'package:mentormatch_apps/mentor/model/category_SMP_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class FisikaSMPScreen extends StatefulWidget {
  FisikaSMPScreen({Key? key}) : super(key: key);

  @override
  State<FisikaSMPScreen> createState() => _FisikaSMPScreenState();
}

class _FisikaSMPScreenState extends State<FisikaSMPScreen> {
  late Future<SMP> futureSMPData;

  @override
  void initState() {
    super.initState();
    futureSMPData = SMPServices().getSMPData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SMP>(
      future: futureSMPData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final mentorsWithLanguageCategory = snapshot.data!.mentors!
              .where((mentor) => mentor.mentorClass!
                  .any((mentorClass) => mentorClass.category == 'Fisika'))
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
              ExperienceSMP? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceSMP(),
              );

                             /// if all class is active ///
              bool areAllClassesActive(List<ClassMentorSMP>? classes) {
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
                        builder: (context) => DetailMentorSMPScreen(
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
