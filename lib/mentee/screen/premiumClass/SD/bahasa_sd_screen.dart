import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class BahasaSDScreen extends StatefulWidget {
  BahasaSDScreen({Key? key}) : super(key: key);

  @override
  State<BahasaSDScreen> createState() => _BahasaSDScreenState();
}

class _BahasaSDScreenState extends State<BahasaSDScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
