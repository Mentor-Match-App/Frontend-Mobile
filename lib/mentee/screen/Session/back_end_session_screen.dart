import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class BackEndSessionScreen extends StatefulWidget {
  BackEndSessionScreen({Key? key}) : super(key: key);

  @override
  State<BackEndSessionScreen> createState() => _BackEndSessionScreenState();
}

class _BackEndSessionScreenState extends State<BackEndSessionScreen> {
  late Future<Session> futureSessionData;

  @override
  void initState() {
    super.initState();
    futureSessionData = SessionServices().getSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Session>(
      future: futureSessionData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final mentorsWithBackEndSession = snapshot.data!.mentors!
              .where((mentor) => mentor.session!.any(
                  (sessionElement) => sessionElement.category == "Back End"))
              .toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: mentorsWithBackEndSession.length,
            itemBuilder: (context, index) {
              final mentor = mentorsWithBackEndSession[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Menyediakan default Experience jika tidak ditemukan
              );
              ////// session active///////

              var firstActiveSession = mentor.session?.firstWhere(
                (s) => s.isActive == true,
                orElse: () =>
                    SessionElement(), // Provide a default session element if no active session is found
              );
              ////// session full///////
              var isSessionFull =
                  (firstActiveSession?.participant?.length ?? 0) >=
                      (firstActiveSession?.maxParticipants ?? 0);
              var numberOfParticipants =
                  firstActiveSession!.participant?.length ?? 0;
              ////// name session///////
              var activeSessionName =
                  firstActiveSession.title ?? "No active session";
              ////// date time session///////
              var activeSessionDateTime =
                  firstActiveSession.dateTime ?? "No date/time provided";
              ////// description session///////
              var activeSessionDescription =
                  firstActiveSession.description ?? "No description provided";
              ////// button color is full //////
              final Color buttonColor = isSessionFull
                  ? ColorStyle().disableColors
                  : ColorStyle().primaryColors;
              /////participant/////
              SessionElement sessionElement = mentor.session!.first;
              int maxParticipants = sessionElement.maxParticipants ?? 0;
              int currentParticipants = sessionElement.participant?.length ?? 0;
              int availableSlots = maxParticipants - currentParticipants;
   
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CardItemMentor(
                  color: buttonColor,
                  onPressesd: isSessionFull
                      ? () {}
                      : () {
                          // Logika untuk navigasi ketika sesi belum penuh
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMentorSessionsNew(
                                availableSlots: availableSlots,
                                sessionsid: mentor.session!
                                        .firstWhere((s) => s.isActive == true)
                                        .id ??
                                    "",

                                participants: numberOfParticipants,
                                about: mentor.about ?? "",
                                namaMentor: mentor.name ?? "",
                                photoUrl: mentor.photoUrl ?? "",
                                job: mentor.experiences
                                        ?.firstWhere(
                                          (exp) => exp.isCurrentJob == true,
                                          orElse: () => Experience(
                                              jobTitle: "", company: ""),
                                        )
                                        .jobTitle ??
                                    "",
                                company: mentor.experiences
                                        ?.firstWhere(
                                          (exp) => exp.isCurrentJob == true,
                                          orElse: () => Experience(
                                              jobTitle: "", company: ""),
                                        )
                                        .company ??
                                    "",
                                email: mentor.email ?? "",
                                linkedin: mentor.linkedin ?? "",
                                skills: mentor.skills ?? [],
                                location: mentor.location ?? "",
                                mentor: mentor,
                                namaSessios: activeSessionName, // Session name
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
