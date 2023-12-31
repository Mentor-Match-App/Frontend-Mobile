import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

/////////////////////////////////////// BIG BUTTON /////////////////////////

//// Elevated Button ////
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
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorStyle().primaryColors)),

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

//// Elevated Button ////

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
          style: FontFamily()
              .buttonText
              .copyWith(color: ColorStyle().primaryColors),
        ),
      ),
    );
  }
}

/////////////////////////////////////// SMALL BUTTON /////////////////////////

/////Elevated Button////////
class SmallElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final double width;
  final String title;
  final Color color;
  final TextStyle? style;

  const SmallElevatedButton({
    Key? key,
    this.onPressed,
    this.title = "", // Provide a default value for title
    this.color = Colors
        .blue, // Provide a default color or choose based on your app's design
    this.style, // You may provide a default style or handle it in the build method
    this.height = 32,
    this.width = 72,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorStyle().primaryColors),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: style, // Use the provided style or a default one
        ),
      ),
    );
  }
}

/////otline Button////////

class SmallOutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final double width;
  final String title;
  final Color color;
  final TextStyle? style;

  const SmallOutlinedButton({
    Key? key,
    this.onPressed,
    this.title = "",
    this.color = Colors.blue,
    this.style,
    this.height = 32,
    this.width = 72,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
                color: ColorStyle().primaryColors), // Set the border color
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

/////////////////////////////////////// BUTTON DETAIL /////////////////////////
class ButtonDetailKegiatan extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback? onTap;

  const ButtonDetailKegiatan({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorStyle().primaryColors,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(firstText, style: FontFamily().buttonText),
              SizedBox(width: 8.0),
              Text(secondText, style: FontFamily().buttonText),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: ColorStyle().whiteColors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
