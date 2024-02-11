import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class CardItemMentor extends StatefulWidget {
  final VoidCallback onPressesd;
  final String imagePath;
  final String name;
  final String job;
  final String company;
  CardItemMentor(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.job,
      required this.company, required this.onPressesd})
      : super(key: key);

  @override
  State<CardItemMentor> createState() => _GirdItemMentorState();
}

class _GirdItemMentorState extends State<CardItemMentor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( right :8.0, left:8.0),
      child: Container(
        height: 240,
        width: 140,
        decoration: BoxDecoration(
          color: ColorStyle().tertiaryColors,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.imagePath,
                height: 102,
                width: 112,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Expanded(
                  child: Text(
                    widget.name,
                    style: FontFamily().boldText.copyWith(
                        color: ColorStyle().secondaryColors, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        size: 16,
                        color: ColorStyle().secondaryColors,
                      ),
                      SizedBox(width: 4),
                        Expanded(
                        child: Text(
                          widget.job,
                          style: FontFamily().regularText.copyWith(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                        ),
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
                      Expanded(
                        child: Text(
                          widget.company,
                          style: FontFamily().regularText.copyWith(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SmallElevatedButton(
                      style: FontFamily().regularText.copyWith(
                          color: ColorStyle().whiteColors, fontSize: 10),
                      height: 28,
                      width: 120,
                      title: "Available",
                      onPressed: widget.onPressesd)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
