import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class CardItemMentor extends StatefulWidget {
  final String imagePath;
  final String name;
  final String job;
  final String company;
  CardItemMentor(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.job,
      required this.company})
      : super(key: key);

  @override
  State<CardItemMentor> createState() => _GirdItemMentorState();
}

class _GirdItemMentorState extends State<CardItemMentor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 230,
        width: 140,
        decoration: BoxDecoration(
          color: ColorStyle().tertiaryColors,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Image.asset(
                widget.imagePath,
                height: 100,
                width: 111,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        size: 16,
                        color: ColorStyle().secondaryColors,
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.job,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        size: 16,
                        color: ColorStyle()
                            .secondaryColors, // Ganti dengan warna yang diinginkan
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.company,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SmallElevatedButton(
                      style: FontFamily().regularText.copyWith(
                          color: ColorStyle().whiteColors, fontSize: 12),
                      height: 24,
                      width: 136,
                      title: "Available",
                      onPressed: () {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
