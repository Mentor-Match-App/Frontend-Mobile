import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_mentor_session.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllSessionScreen extends StatefulWidget {
  AllSessionScreen({Key? key}) : super(key: key);

  @override
  State<AllSessionScreen> createState() => _AllSessionScreenState();
}

class _AllSessionScreenState extends State<AllSessionScreen> {
late Future<Session> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = SessionServices().getSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Session>(
      future: _sessionFuture,
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
              childAspectRatio: 3 / 4,
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
                  onPressesd: () {
                  // Assuming you are still working with the first active session
                  var firstActiveSession = mentor.session?.firstWhere(
                    (s) => s.isActive == true,
                    orElse: () =>
                        SessionElement(), // Provide a default session element if no active session is found
                  );
                  var numberOfParticipants =
                      firstActiveSession!.participant?.length ?? 0;
                  var activeSessionName =
                      firstActiveSession.title ?? "No active session";
                  var activeSessionDateTime =
                      firstActiveSession.dateTime ?? "No date/time provided";
                  var activeSessionDescription =
                      firstActiveSession.description ??
                          "No description provided";

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMentorSession(
                        participants: numberOfParticipants,
                        about: mentor.about ?? "",
                        namaMentor: mentor.name ?? "",
                        photoUrl: mentor.photoUrl ?? "",
                        job: mentor.experiences
                                ?.firstWhere(
                                  (exp) => exp.isCurrentJob == true,
                                  orElse: () =>
                                      Experience(jobTitle: "", company: ""),
                                )
                                .jobTitle ??
                            "",
                        company: mentor.experiences
                                ?.firstWhere(
                                  (exp) => exp.isCurrentJob == true,
                                  orElse: () =>
                                      Experience(jobTitle: "", company: ""),
                                )
                                .company ??
                            "",
                        email: mentor.email ?? "",
                        linkedin: mentor.linkedin ?? "",
                        skills: mentor.skills ?? [],
                        location: mentor.location ?? "",
                        mentor: mentor,
                        namaSessios: activeSessionName, // Session name
                        jadwal: activeSessionDateTime, // Session date/time
                        description:
                            activeSessionDescription, // Session description
                      ),
                    ),
                  );
                },
                  imagePath:
                      mentor.photoUrl ?? 'assets/Handoff/ilustrator/profile.png',
                  name: mentor.name ?? 'No Name',
                  job: currentExperience.jobTitle ?? '',
                  company: currentExperience.company ?? 'Placeholder Company',
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
