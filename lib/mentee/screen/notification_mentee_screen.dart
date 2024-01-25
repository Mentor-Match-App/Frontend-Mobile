import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class NotificationMenteeScreen extends StatefulWidget {
  NotificationMenteeScreen({Key? key}) : super(key: key);

  @override
  State<NotificationMenteeScreen> createState() => _NotificationMenteeScreenState();
}

class _NotificationMenteeScreenState extends State<NotificationMenteeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification", style: FontFamily().titleText),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notification_add,
                        size: 36,
                        color: ColorStyle().primaryColors,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pengingat Aktivasi Akun',
                                style: FontFamily().boldText.copyWith(
                                    fontSize: 16,
                                    color: ColorStyle().secondaryColors),
                              ),
                              Text(
                                "Kami ingin memberi tahu Anda bahwa akun sosial media Anda telah lama tidak digunakan  Kami rindu melihat Anda aktif dan berbagi momen-momen menarik dengan komunitas kamu.",
                                style: FontFamily().regularText,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notification_add,
                        size: 36,
                        color: ColorStyle().primaryColors,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pengingat Aktivasi Akun',
                                style: FontFamily().boldText.copyWith(
                                    fontSize: 16,
                                    color: ColorStyle().secondaryColors),
                              ),
                              Text(
                                "Kami ingin memberi tahu Anda bahwa akun sosial media Anda telah lama tidak digunakan  Kami rindu melihat Anda aktif dan berbagi momen-momen menarik dengan komunitas kamu.",
                                style: FontFamily().regularText,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
