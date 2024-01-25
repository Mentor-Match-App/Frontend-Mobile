import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/createClass_Session/form_create_class.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class HomeMentorScreen extends StatefulWidget {
  const HomeMentorScreen({Key? key}) : super(key: key);

  @override
  State<HomeMentorScreen> createState() => _HomeMentorScreenState();
}

class _HomeMentorScreenState extends State<HomeMentorScreen> {
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
                        Text("Jelajahi Dunia Mentoring yang Menginspirasi",
                            style: FontFamily()
                                .titleText
                                .copyWith(color: ColorStyle().primaryColors)),
                        const SizedBox(height: 2),
                        Text(
                          "Bagikan kisah sukses dan tantangan pribadi Anda. Ini membuat Anda lebih mudah dicapai dan memberikan inspirasi nyata. Dorong peserta untuk berpikir kritis dengan mengajukan pertanyaan terbuka. Ini membuka pintu untuk diskusi yang mendalam.",
                          style: FontFamily().regularText,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SmallElevatedButton(
                          height: 36,
                          width: 140,
                          title: "Buat Kelas",
                          style: FontFamily().buttonText.copyWith(
                                fontSize: 12,
                                color: ColorStyle().whiteColors,
                              ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormCreatePremiumClassScreen(),
                              ),
                            );
                          },
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
                            'assets/Handoff/ilustrator/mentor in zoom.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ColorStyle()
                      .tertiaryColors // Set your desired background color
                  ),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/Handoff/ilustrator/learn by online.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                            textAlign: TextAlign.right,
                            "Pimpin Perubahan, Jadi Mentor dalam Sesi Inovatif dan Pendidikan",
                            style: FontFamily()
                                .titleText
                                .copyWith(color: ColorStyle().primaryColors)),
                        const SizedBox(height: 2),
                        Text(
                          textAlign: TextAlign.right,
                          "Bagikan kisah sukses dan tantangan pribadi Anda. Ini membuat Anda lebih mudah dicapai dan memberikan inspirasi nyata. Dorong peserta untuk berpikir kritis dengan mengajukan pertanyaan terbuka. Ini membuka pintu untuk diskusi yang mendalam.",
                          style: FontFamily().regularText,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SmallElevatedButton(
                            height: 36,
                            width: 140,
                            title: "Buat Session",
                            style: FontFamily().buttonText.copyWith(
                                  fontSize: 12,
                                  color: ColorStyle().whiteColors,
                                ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FormCreatePremiumClassScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
