import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/model/mentor_model.dart';
import 'package:mentormatch_apps/mentor/service/mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class HomeMenteeScreen extends StatelessWidget {
  final MentorService apiService = MentorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/Handoff/logo/LogoMobile.png'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationMenteeScreen(),
                  ),
                );
              },
              icon: Icon(Icons.notifications_none_outlined),
              color: ColorStyle().secondaryColors,
            )
          ],
        ),
      ),
      body: FutureBuilder<MentorModel>(
        future: apiService.fetchMentors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData ||
              (snapshot.data?.mentors?.isEmpty ?? true)) {
            return const Center(child: Text('Tidak ada data mentor'));
          }

          // Provide a default empty list if `mentors` is null
          List<Mentor> mentors = snapshot.data!.mentors ?? [];
          return CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorStyle()
                      .tertiaryColors, // Set your desired background color
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hai,",
                                style: FontFamily().regularText,
                              ),
                              const SizedBox(width: 4),
                              Text("Charline",
                                  style: FontFamily().boldText.copyWith(
                                      color: ColorStyle().secondaryColors)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text("Selamat Datang di Aplikasi Mentoring Terbaik!",
                              style: FontFamily()
                                  .titleText
                                  .copyWith(color: ColorStyle().primaryColors)),
                          const SizedBox(height: 2),
                          Text(
                            "Buka pintu kesuksesan dan pertumbuhan pribadi Anda. Temukan mentor atau jadilah mentor yang memimpin. Mulai petualangan menuju puncak kesuksesan bersama kami.",
                            style: FontFamily().regularText,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/Handoff/ilustrator/looking mentor.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 12, bottom: 8),
                child: Text(
                  "Popular Mentor",
                  style: FontFamily().titleText.copyWith(fontSize: 14),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final mentor = mentors[index];
                  return CardItemMentor(
                     onPressesd: () {},
                    imagePath:
                        mentor.photoUrl ?? '', // Ubah ke foto mentor jika ada
                    name: mentor.name ?? '',
                    job: mentor.experience!.first.jobTitle ?? '',
                    company: mentor.experience!.first.company ?? '',
                  );
                },
                childCount: mentors.length,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 12, bottom: 8),
                child: Text(
                  "Popular Mentor",
                  style: FontFamily().titleText.copyWith(fontSize: 14),
                ),
              ),
            ),
            // Tambahkan Row di sini jika diperlukan
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorStyle().tertiaryColors,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/Handoff/ilustrator/learn together 2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .end, // Align text to the right
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                "Program & Layanan",
                                style: FontFamily().titleText,
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Dapatkan akses eksklusif ke mentor pilihan Anda yang akan membimbing langkah-langkah Anda menuju sukses. Mereka adalah ahli di bidang mereka dan siap membantu Anda mencapai tujuan Anda.",
                                style: FontFamily().regularText,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SmallElevatedButton(
                            title: 'SD',
                            color: ColorStyle().secondaryColors,
                            style: FontFamily()
                                .buttonText
                                .copyWith(fontSize: 12.0),
                          ),
                          SmallElevatedButton(
                            title: 'SD',
                            color: ColorStyle().secondaryColors,
                            style: FontFamily()
                                .buttonText
                                .copyWith(fontSize: 12.0),
                          ),
                          SmallElevatedButton(
                            title: 'SD',
                            color: ColorStyle().secondaryColors,
                            style: FontFamily()
                                .buttonText
                                .copyWith(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SmallElevatedButton(
                          title: 'SD',
                          color: ColorStyle().secondaryColors,
                          style:
                              FontFamily().buttonText.copyWith(fontSize: 12.0),
                        ),
                        SmallElevatedButton(
                          color: ColorStyle().secondaryColors,
                          title: 'SD',
                          style:
                              FontFamily().buttonText.copyWith(fontSize: 12.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
