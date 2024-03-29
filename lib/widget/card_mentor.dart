import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class CardItemMentor extends StatefulWidget {
  
  final VoidCallback onPressesd;
  final String imagePath;
  final String name;
  final String job;
  final String company;
  final Color color; 
  CardItemMentor({
    Key? key,
    required this.onPressesd,
    required this.imagePath,
    required this.name,
    required this.job,
    required this.company,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  State<CardItemMentor> createState() => _CardItemMentorState();
}

class _CardItemMentorState extends State<CardItemMentor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyle().tertiaryColors,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: ColorStyle().secondaryColors,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.work, size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.job,
                          style: TextStyle(fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.home_work_outlined, size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.company,
                          style: TextStyle(fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Tombol hanya ditampilkan sekali di bagian bawah
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: SmallElevatedButton(
                color: widget.color,
                style: FontFamily().regularText.copyWith(
                    color: ColorStyle().whiteColors, fontSize: 10),
                height: 28,
                width: double.infinity, // Menyesuaikan lebar tombol dengan container
                title: "Available",
                onPressed: widget.onPressesd,
              ),
            ),
            SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
