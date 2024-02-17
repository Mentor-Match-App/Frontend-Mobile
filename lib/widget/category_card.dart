import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class CategoriCardWidget extends StatefulWidget {
  final bool isActive;
  final String img;
  final String title;
  final VoidCallback? onTap;
  CategoriCardWidget(
      {Key? key,
      required this.img,
      required this.title,
      this.onTap,
      required this.isActive})
      : super(key: key);

  @override
  State<CategoriCardWidget> createState() => _CategoriCardWidgetState();
}

class _CategoriCardWidgetState extends State<CategoriCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.img, height: 32, width: 32),
            const SizedBox(height: 8), // Add space between image and text
            Text(
              widget.title,
              style: FontFamily().boldText.copyWith(
                    fontSize: 12,
                    color: widget.isActive
                        ? ColorStyle().primaryColors
                        : ColorStyle().disableColors,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String skill;
  SkillCard({Key? key, required this.skill}) : super(key: key);

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorStyle().secondaryColors,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.skill, style: FontFamily().regularText),
          ),
        ),
      ),
    );
  }
}
