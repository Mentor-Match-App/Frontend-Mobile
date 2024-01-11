import 'package:flutter/material.dart';
import 'package:mentormatch_apps/screen/MyClass/Detail_myClass_screen.dart';
import 'package:mentormatch_apps/screen/bottom_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class ReviewMentorScreen extends StatefulWidget {
  ReviewMentorScreen({Key? key}) : super(key: key);

  @override
  State<ReviewMentorScreen> createState() => _ReviewMentorScreenState();
}

class _ReviewMentorScreenState extends State<ReviewMentorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Mentor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset("assets/Handoff/ilustrator/review.png"),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                    textAlign: TextAlign.center,
                    "Halo Charline, pastikan memberikan review setelah menyelesaikan program ini. Ingat, satu rewiew saja di akhir program. Gunakan kata-kata dengan bijak dalam memberikan ulasan. Nama dan ulasanmu akan terlihat di profil mentor. Terima kasih!",
                    style: FontFamily().regularText),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Tulis Review",
                  hintStyle: FontFamily().regularText,
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmallOutlinedButton(
                    height: 32,
                    width: 120,
                    title: "Batal",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().primaryColors,
                        ),
                    onPressed: () {
                      // Gantikan halaman saat ini dengan BottomNavbarScreen
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMyClassScreen()));
                    },
                  ),
                  SmallElevatedButton(
                    height: 32,
                    width: 120,
                    title: "Kirim",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().whiteColors,
                        ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavbarScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
