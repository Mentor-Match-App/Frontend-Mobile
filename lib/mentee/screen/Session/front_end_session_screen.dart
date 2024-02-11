import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class FrontEndSessionScreen extends StatefulWidget {
  FrontEndSessionScreen({Key? key}) : super(key: key);

  @override
  State<FrontEndSessionScreen> createState() => _FrontEndSessionScreenState();
}

class _FrontEndSessionScreenState extends State<FrontEndSessionScreen> {
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
          final mentorsWithFronEndSession = snapshot.data!.mentors!
              .where((mentor) => mentor.session!.any(
                  (sessionElement) => sessionElement.category == "Front End"))
              .toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: mentorsWithFronEndSession.length,
            itemBuilder: (context, index) {
              final mentor = mentorsWithFronEndSession[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Menyediakan default Experience jika tidak ditemukan
              );

              return CardItemMentor(
                 onPressesd: () {},
                imagePath:
                    mentor.photoUrl ?? 'assets/Handoff/ilustrator/profile.png',
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
