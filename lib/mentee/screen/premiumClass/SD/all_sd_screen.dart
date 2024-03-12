import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SD/detail_mentor_SD_screen.dart';
import 'package:mentormatch_apps/mentee/service/service_SD_mentor.dart';
import 'package:mentormatch_apps/mentor/model/category_SD_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllSDScreen extends StatefulWidget {
  AllSDScreen({Key? key}) : super(key: key);

  @override
  State<AllSDScreen> createState() => _AllSDScreenState();
}

class _AllSDScreenState extends State<AllSDScreen> {
  late Future<SD> futureSDData;

  @override
  void initState() {
    super.initState();
    futureSDData = SDServices().getSDData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SD>(
      future: futureSDData,
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
              // create for experience is current job true or false
              ExperienceSD? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceSD(),
              );

              /// if all class is active ///
              bool areAllClassesActive(List<ClassMentorSD>? classes) {
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
                  color: buttonColor,
                 onPressesd: allClassesActive ?() {} : (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMentorSDScreen(
                            
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
                    } , // Jika semua kelas aktif, tidak melakukan apa-apa
                  imagePath: mentor.photoUrl.toString(),
                  name: mentor.name ?? 'No Name',
                  job: jobTitle,
                  company: company,
                ),
              );
            },
            shrinkWrap: true,
            physics:
                ScrollPhysics(), // Allows scrolling within a SingleChildScrollView
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
