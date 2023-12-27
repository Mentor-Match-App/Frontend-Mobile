import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ColorStyle()
                      .tertiaryColors // Set your desired background color
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
                        Text(
                          "Selamat Datang di Aplikasi Mentoring Terbaik!",
                          style: FontFamily().titleText.copyWith( color: ColorStyle().primaryColors)
                        ),
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

            Padding(
              padding: const EdgeInsets.only(top: 24, left: 12, bottom: 8),
              child: Text(
                "Popular Mentor",
                style: FontFamily().titleText.copyWith(fontSize: 14),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 2,
            //       mainAxisSpacing: 2,
            //       childAspectRatio: 121 / 131,
            //     ),
            //     itemCount: 4, // Change this based on your mentor count
            //     itemBuilder: (context, index) {
            //       return SizedBox(
            //         width: double.infinity,
            //         child: CardItemMentor(
            //           imagePath: 'assets/Handoff/ilustrator/profile.png',
            //           name: 'Charline',
            //           job: 'UI/UX Designer',
            //           company: 'Google',
            //         ),
            //       );
            //     },
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardItemMentor(
                  imagePath:
                      // 'assets/Handoff/ilustrator/mentor${index + 1}.png',
                      'assets/Handoff/ilustrator/profile.png',
                  name: 'Charline',
                  job: 'UI/UX Designer',
                  company: 'Google',
                ),
                CardItemMentor(
                  imagePath:
                      // 'assets/Handoff/ilustrator/mentor${index + 1}.png',
                      'assets/Handoff/ilustrator/profile.png',
                  name: 'Charline',
                  job: 'UI/UX Designer',
                  company: 'Google',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardItemMentor(
                  imagePath:
                      // 'assets/Handoff/ilustrator/mentor${index + 1}.png',
                      'assets/Handoff/ilustrator/profile.png',
                  name: 'Charline',
                  job: 'UI/UX Designer',
                  company: 'Google',
                ),
                CardItemMentor(
                  imagePath:
                      // 'assets/Handoff/ilustrator/mentor${index + 1}.png',
                      'assets/Handoff/ilustrator/profile.png',
                  name: 'Charline',
                  job: 'UI/UX Designer',
                  company: 'Google',
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
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
                          crossAxisAlignment:
                              CrossAxisAlignment.end, // Align text to the right
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
                          style:
                              FontFamily().buttonText.copyWith(fontSize: 12.0),
                        ),
                        SmallElevatedButton(
                          title: 'SD',
                          color: ColorStyle().secondaryColors,
                          style:
                              FontFamily().buttonText.copyWith(fontSize: 12.0),
                        ),
                        SmallElevatedButton(
                          title: 'SD',
                          color: ColorStyle().secondaryColors,
                          style:
                              FontFamily().buttonText.copyWith(fontSize: 12.0),
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
                        style: FontFamily().buttonText.copyWith(fontSize: 12.0),
                      ),
                      SmallElevatedButton(
                        color: ColorStyle().secondaryColors,
                        title: 'SD',
                        style: FontFamily().buttonText.copyWith(fontSize: 12.0),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
