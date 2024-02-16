import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';

import '../style/font_style.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final bool? enabled; // tambahkan properti enabled

  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.formKey,
    this.controller,
    this.enabled = true,
    Function(String p1)? onChanged, // inisialisasi properti enabled
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SizedBox(
        height: 38,
        child: TextFormField(
          controller: widget.controller,
          enabled: widget.enabled, // gunakan properti enabled
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorStyle().tertiaryColors,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            hintStyle: FontFamily().regularText.copyWith(
                  color: ColorStyle().disableColors,
                ),
          ),
        ),
      ),
    );
  }
}
