import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class CardPremiumClassOptions extends StatefulWidget {
  final String image;

  final String? description;
  final VoidCallback? onPressed;
  const CardPremiumClassOptions(
      {Key? key,  this.description, this.onPressed, required this.image})
      : super(key: key);

  @override
  State<CardPremiumClassOptions> createState() =>
      _CardPremiumClassOptionsState();
}

class _CardPremiumClassOptionsState extends State<CardPremiumClassOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: ColorStyle().tertiaryColors,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 130,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(widget.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.description!, style: FontFamily().regularText),
                    const SizedBox(height: 12),
                    SmallElevatedButton(
                      width: 120,
                      height: 36,
                      onPressed: widget.onPressed,
                      title: 'Lihat Kelas',
                      color: ColorStyle().primaryColors,
                      style: FontFamily().buttonText.copyWith(
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
