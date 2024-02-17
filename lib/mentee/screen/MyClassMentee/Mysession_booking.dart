import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class MySessionBooking extends StatefulWidget {
  MySessionBooking({Key? key}) : super(key: key);

  @override
  State<MySessionBooking> createState() => _MySessionBookingState();
}

class _MySessionBookingState extends State<MySessionBooking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle().tertiaryColors,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.asset(
                      fit: BoxFit.cover,
                      "assets/Handoff/Ilustrator/profile.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "UI/UX Design",
                          style: FontFamily().boldText,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "30 Hari",
                          style: FontFamily().regularText,
                        ),
                        Text(
                          'Mentor ',
                          style: FontFamily().regularText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'htttps/inilinkmentorigyangakankamuakses',
                      style: FontFamily().boldText,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {
                      // Menyalin teks ke clipboard
                      Clipboard.setData(const ClipboardData(
                          text: 'htttps/inilinkmentorigyangakankamuakses'));

                      // Tampilkan snackbar atau pesan bahwa teks telah disalin
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          backgroundColor: ColorStyle().tertiaryColors,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Link disalin',
                            style: FontFamily().regularText,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
