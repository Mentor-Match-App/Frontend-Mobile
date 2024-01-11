import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class CardCommunity extends StatefulWidget {
  final String title;

  final String imagePath;
  CardCommunity({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  State<CardCommunity> createState() => _GirdItemMentorState();
}

class _GirdItemMentorState extends State<CardCommunity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 210,
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
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Text(
                  textAlign: TextAlign.center,
                  widget.title,
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().secondaryColors, fontSize: 12),
                ),
              ),
              SmallElevatedButton(
                  style: FontFamily()
                      .regularText
                      .copyWith(color: ColorStyle().whiteColors, fontSize: 12),
                  height: 24,
                  width: 136,
                  title: "Bergabung",
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
