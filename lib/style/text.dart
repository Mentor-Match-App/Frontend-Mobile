import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class TittleTextField extends StatelessWidget {
  final String? title;
  final Color? color;
  final TextAlign? textAlign;
  const TittleTextField({Key? key, this.title, this.color, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title!,
        style: FontFamily().regularText.copyWith(
              color: color,
            ),
        textAlign: textAlign,
      ),
    );
  }
}
