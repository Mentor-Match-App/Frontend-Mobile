import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premiumClass/SMA/detail_mentor_SMA.dart';
import 'package:mentormatch_apps/mentee/service/service_SMA_mentor.dart';
import 'package:mentormatch_apps/mentor/model/category_SMA_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllSMAScreen extends StatefulWidget {
  AllSMAScreen({Key? key}) : super(key: key);

  @override
  State<AllSMAScreen> createState() => _AllSMAScreenState();
}

class _AllSMAScreenState extends State<AllSMAScreen> {
  late Future<SMA> futureSMAData;

  @override
  void initState() {
    super.initState();
    futureSMAData = SMAServices().getSMAData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SMA>(
      future: futureSMAData,
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
              // Assuming `isAvailable` is a boolean property of mentorClass
              final bool isClassAvailable = mentor.mentorClass?.isAvailable ??
                  false; // Default to false if null

              // Determine the button color based on the availability of the class
              final Color buttonColor = isClassAvailable
                  ? ColorStyle().primaryColors
                  : ColorStyle().disableColors;

              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Provide a default Experience if not found
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemMentor(
                  color:
                      buttonColor, // Use the determined color based on class availability
                  onPressesd: isClassAvailable
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMentorSMAScreen(
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
