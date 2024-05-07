import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/session/session_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

class AppBarPremiumClass extends StatefulWidget {
  AppBarPremiumClass({Key? key}) : super(key: key);

  @override
  State<AppBarPremiumClass> createState() => _AppBarPremiumClassState();
}

class _AppBarPremiumClassState extends State<AppBarPremiumClass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<int>(
          // add icon, by default "3 dot" icon
          child: Row(
            children: [
              const Icon(Icons.arrow_drop_down_outlined),
              Text(
                "Program & Layanan",
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().primaryColors, fontSize: 14),
              ),
            ],
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Premium Class",
                  style: FontFamily().regularText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 14),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Session",
                  style: FontFamily().regularText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 14),
                ),
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
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active,
              color: ColorStyle().secondaryColors,
            ))
      ],
    );
  }
}

class AppBarLogoNotif extends StatefulWidget {
  AppBarLogoNotif({Key? key}) : super(key: key);

  @override
  State<AppBarLogoNotif> createState() => _AppBarLogoNotifState();
}

class _AppBarLogoNotifState extends State<AppBarLogoNotif> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/Handoff/logo/LogoMobile.png'),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationMenteeScreen(),
              ),
            );
          },
          icon: Icon(Icons.notifications_none_outlined),
          color: ColorStyle().secondaryColors,
        )
      ],
    );
  }
}

class AppBarHomePage extends StatefulWidget {
  AppBarHomePage({Key? key}) : super(key: key);

  @override
  State<AppBarHomePage> createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/Handoff/logo/LogoMobile.png',
          width: 120,
          height: 120,
        ),
        // SizedBox(
        //   width: 20,
        // ),
        PopMenuButtonWidget(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationMenteeScreen(),
              ),
            );
          },
          icon: Icon(Icons.notifications_none_outlined),
          color: ColorStyle().secondaryColors,
        )
      ],
    );
  }
}
