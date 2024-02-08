import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class ManajemenKuliahScreen extends StatefulWidget {
  ManajemenKuliahScreen({Key? key}) : super(key: key);

  @override
  State<ManajemenKuliahScreen> createState() => _ManajemenKuliahScreenState();
}

class _ManajemenKuliahScreenState extends State<ManajemenKuliahScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Manajemen',
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
