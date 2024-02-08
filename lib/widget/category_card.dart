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
