import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class ComputerScinceKuliahScreen extends StatefulWidget {
  ComputerScinceKuliahScreen({Key? key}) : super(key: key);

  @override
  State<ComputerScinceKuliahScreen> createState() => _ComputerScinceKuliahScreenState();
}

class _ComputerScinceKuliahScreenState extends State<ComputerScinceKuliahScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Computer',
                job: 'UI/UX Computer',
                company: 'Google'),
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Charline June',
                job: 'UI/UX Computer',
                company: 'Google'),
          ],
        ),
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Charline June',
                job: 'UI/UX Computer',
                company: 'Google'),
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'Charline June',
                job: 'UI/UX Computer',
                company: 'Google'),
          ],
        ),
      ],
    );
  }
}
