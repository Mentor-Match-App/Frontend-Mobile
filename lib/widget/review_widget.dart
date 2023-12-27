import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class ReviewWidget extends StatelessWidget {
  final String name;
  final String review;
  const ReviewWidget({Key? key, required this.name, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.emoji_emotions_outlined,
                  size: 40, color: ColorStyle().secondaryColors),
              SizedBox(
                width: 4,
              ),
              Text(
                name,
                style: FontFamily().titleText.copyWith(
                    color: ColorStyle().secondaryColors, fontSize: 12),
              ),
            ],
          ),
          Text(
            review,
            style: FontFamily().regularText,
          )
        ],
      ),
    );
  }
}
