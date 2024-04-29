import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/Karier/Karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/Kuliah/Kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/SD/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/SMA/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/SMP/SMP_screen.dart';
import 'package:mentormatch_apps/widget/card_premium_class.dart';
import 'package:mentormatch_apps/widget/navbar.dart';

class PremiumClassScreen extends StatefulWidget {
  const PremiumClassScreen({Key? key}) : super(key: key);

  @override
  State<PremiumClassScreen> createState() => _PremiumClassScreenState();
}

class _PremiumClassScreenState extends State<PremiumClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/Handoff/logo/LogoMobile.png'),
            PopMenuButtonWidget(),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SDScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/SD.png',
                  description:
                      'Nikmati pembelajaran yang lebih baik dengan dukungan khusus dari mentor untuk tingkat SD yang membantu Anda dalam proses pembelajaran.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SMPScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/SMP.png',
                  description:
                      'Nikmati bimbingan personal dari mentor ahli yang akan membimbing Anda dalam memahami pelajaran dan membuka wawasan baru.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SMAScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/SMA.png',
                  description:
                      'Dapatkan dukungan khusus dari mentor kami untuk pembelajaran yang optimal dan persiapan ujian perguruan tinggi yang sukses.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KuliahScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/KULIAH.png',
                  description:
                      'Dapatkan panduan khusus dari mentor mahasiswa kami untuk meraih keberhasilan akademis dan persiapkan diri Anda untuk masa depan karier yang cemerlang.',
                ),
                CardPremiumClassOptions(
                 onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KarierScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/KARIER.png',
                  description:
                      'Temukan dukungan khusus dari mentor profesional kami untuk merancang dan mengembangkan karier Anda.',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
