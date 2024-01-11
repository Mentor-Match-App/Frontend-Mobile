import 'package:flutter/material.dart';
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
        children: const [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CardPremiumClassOptions(
                  onPressed: null,
                  title: 'SD',
                  description:
                      'Nikmati pembelajaran yang lebih baik dengan dukungan khusus dari mentor untuk tingkat SD yang membantu Anda dalam proses pembelajaran.',
                ),
                CardPremiumClassOptions(
                  onPressed: null,
                  title: 'SMP',
                  description:
                      'Nikmati bimbingan personal dari mentor ahli yang akan membimbing Anda dalam memahami pelajaran dan membuka wawasan baru.',
                ),
                CardPremiumClassOptions(
                  onPressed: null,
                  title: 'SMA',
                  description:
                      'Dapatkan dukungan khusus dari mentor kami untuk pembelajaran yang optimal dan persiapan ujian perguruan tinggi yang sukses.',
                ),
                CardPremiumClassOptions(
                  onPressed: null,
                  title: 'Kuliah',
                  description:
                      'Dapatkan panduan khusus dari mentor mahasiswa kami untuk meraih keberhasilan akademis dan persiapkan diri Anda untuk masa depan karier yang cemerlang.',
                ),
                CardPremiumClassOptions(
                  onPressed: null,
                  title: 'Karier',
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
