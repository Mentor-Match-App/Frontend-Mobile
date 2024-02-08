import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class BahasaKuliahScreen extends StatefulWidget {
  BahasaKuliahScreen({Key? key}) : super(key: key);

  @override
  State<BahasaKuliahScreen> createState() => _BahasaKuliahScreenState();
}

class _BahasaKuliahScreenState extends State<BahasaKuliahScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'BAHASA',
                job: 'UI/UX Designer',
                company: 'Google'),
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Charline June',
                job: 'UI/UX Designer',
                company: 'Google'),
          ],
        ),
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Charline June',
                job: 'UI/UX Designer',
                company: 'Google'),
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Charline June',
                job: 'UI/UX Designer',
                company: 'Google'),
          ],
        ),
      ],
    );
  }
}
