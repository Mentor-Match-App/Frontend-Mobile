import 'package:flutter/material.dart';
import 'package:mentormatch_apps/screen/Session/session_screen.dart';
import 'package:mentormatch_apps/screen/premiumClass/premium_class_screen.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class PopMenuButtonWidget extends StatefulWidget {
  PopMenuButtonWidget({Key? key}) : super(key: key);

  @override
  State<PopMenuButtonWidget> createState() => _PopMenuButtonWidgetState();
}

class _PopMenuButtonWidgetState extends State<PopMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
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
        // Handle the selected value
        switch (value) {
          case 0:
            // Navigasi ke halaman Premium Class
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PremiumClassScreen()),
              (route) => false,
            );
            break;
          case 1:
            // Navigasi ke halaman Session
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SessionScreen()),
              (route) => false,
            );
            break;
        }
      },
    );
  }
}
