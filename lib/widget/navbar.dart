import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class PopMenuButtonWidget extends StatefulWidget {
  PopMenuButtonWidget({Key? key}) : super(key: key);

  @override
  State<PopMenuButtonWidget> createState() => _PopMenuButtonWidgetState();
}

class _PopMenuButtonWidgetState extends State<PopMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        child: Row(
          children: [
            const Icon(Icons.arrow_drop_down_outlined),
            Text(
              "Program & Layanan",
              style: FontFamily().regularText,
            ),
          ],
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Text("Premium Class"),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Text("Session"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            print("My account menu is selected.");
          } else if (value == 1) {
            print("Settings menu is selected.");
          } else if (value == 2) {
            print("Logout menu is selected.");
          }
        });
  }
}
