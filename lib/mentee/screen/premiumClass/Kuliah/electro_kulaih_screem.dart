import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class ElectroKuliahScreen extends StatefulWidget {
  ElectroKuliahScreen({Key? key}) : super(key: key);

  @override
  State<ElectroKuliahScreen> createState() => _ElectroKuliahScreenState();
}

class _ElectroKuliahScreenState extends State<ElectroKuliahScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'ELECTRO',
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
