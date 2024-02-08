import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class PsikologKuliahScreen extends StatefulWidget {
  PsikologKuliahScreen({Key? key}) : super(key: key);

  @override
  State<PsikologKuliahScreen> createState() => _PsikologKuliahScreenState();
}

class _PsikologKuliahScreenState extends State<PsikologKuliahScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Psikolog',
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
