import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllSDScreen extends StatefulWidget {
  AllSDScreen({Key? key}) : super(key: key);

  @override
  State<AllSDScreen> createState() => _AllSDScreenState();
}

class _AllSDScreenState extends State<AllSDScreen> {
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
