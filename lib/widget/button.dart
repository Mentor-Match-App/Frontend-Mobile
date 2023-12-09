import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final Color? color;
  const ElevatedButtonWidget({Key? key, this.onPressed, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 396,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffE78938)),
        ),

        onPressed: onPressed,
        // },
        child: Text(
          title!,
          style: FontFamily().buttonText,
        ),
      ),
    );
  }
}

class OutlineButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final Color? color;
  const OutlineButtonWidget({Key? key, this.onPressed, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 396,
      height: 48,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Color(0xffE78938)), // Warna garis outline
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title!,
          style:
              FontFamily().buttonText.copyWith(color: ColorStyle().primaryColors),
        ),
      ),
    );
  }
}
