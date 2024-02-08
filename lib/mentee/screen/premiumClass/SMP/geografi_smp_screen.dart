import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class GeografiSMPScreen extends StatefulWidget {
  GeografiSMPScreen({Key? key}) : super(key: key);

  @override
  State<GeografiSMPScreen> createState() => _GeografiSMPScreenState();
}

class _GeografiSMPScreenState extends State<GeografiSMPScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CardItemMentor(
                imagePath: 'assets/Handoff/ilustrator/profile.png',
                name: 'GEO',
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
