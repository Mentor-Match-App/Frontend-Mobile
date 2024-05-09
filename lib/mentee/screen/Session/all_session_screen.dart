import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
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
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          /// menampilkan mentor yang isActive == true
          final mentors = snapshot.data!.mentors ?? [];

          // Set untuk menyimpan ID mentor yang sudah ditampilkan
          Set<String> displayedMentorIds = Set();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 350,
                maxCrossAxisExtent: 250),
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              final mentor = mentors[index];
              final mentorId = mentor.id ?? "";

              // Periksa apakah ID mentor sudah ditampilkan sebelumnya
              if (displayedMentorIds.contains(mentorId)) {
                // Jika sudah ditampilkan, maka jangan tampilkan lagi
                return SizedBox.shrink();
              } else {
                // Jika belum ditampilkan, tambahkan ID mentor ke Set
                displayedMentorIds.add(mentorId);

                // Mengambil semua sesi aktif dari mentor
                final activeSessions = mentor.session
                        ?.where((session) => session.isActive == true)
                        .toList() ??
                    [];

                // Mendapatkan pengalaman kerja terkini mentor
                final currentExperience = mentor.experiences?.firstWhere(
                  (experience) => experience.isCurrentJob ?? false,
                  orElse: () => Experience(),
                );

                // Mendapatkan status ketersediaan sesi
                final isSessionFull = activeSessions.isNotEmpty &&
                    activeSessions.any((session) =>
                        session.participant?.length == session.maxParticipants);

                // Mendapatkan jumlah peserta sesi
                final numberOfParticipants = activeSessions.isNotEmpty
                    ? activeSessions.first.participant?.length ?? 0
                    : 0;

                // Mendapatkan warna tombol sesuai dengan status ketersediaan sesi
                final Color buttonColor = isSessionFull
                    ? ColorStyle().disableColors
                    : ColorStyle().primaryColors;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardItemMentor(
                    title: isSessionFull ? "Full Booked" : "Available",
                    color: buttonColor,
                    onPressesd: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMentorSessionsNew(
                            session: mentor.session,
                            availableSlots: mentor.session!.isEmpty
                                ? 0
                                : mentor.session!.first.maxParticipants! -
                                    (mentor.session!.first.participant
                                            ?.length ??
                                        0),
                            detailmentor: mentor,
                            totalParticipants: numberOfParticipants,
                            mentorReviews: mentor.mentorReviews ?? [],
                          ),
                        ),
                      );
                    },
                    imagePath: mentor.photoUrl ??
                        'assets/Handoff/ilustrator/profile.png',
                    name: mentor.name ?? 'No Name',
                    job: currentExperience?.jobTitle ?? '',
                    company:
                        currentExperience?.company ?? 'Placeholder Company',
                  ),
                );
              }
            },
            shrinkWrap: true,
            physics: ScrollPhysics(),
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
