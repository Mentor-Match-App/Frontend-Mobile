import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';

import '../style/font_style.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText;
  final GlobalKey<FormState>? keyword;
  final TextEditingController? controller; // Add controller property

  const TextFieldWidget(
      {super.key, this.hintText, this.controller, this.keyword});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 332,
      child: TextFormField(
        key: widget.keyword,
        controller: widget.controller, // Set the controller
        // keyboardType: TextInputType.multiline,
        // minLines: 5,
        // maxLines: 10,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorStyle().tertiaryColors,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none),
          hintText: widget.hintText,
          hintStyle: FontFamily()
              .regularText
              .copyWith(color: ColorStyle().disableColors),
        ),
      ),
    );
  }
}
