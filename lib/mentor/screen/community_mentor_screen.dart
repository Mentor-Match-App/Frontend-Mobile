import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_community.dart';
import 'package:mentormatch_apps/widget/navbar.dart';

class CommunityMentorScreen extends StatefulWidget {
  CommunityMentorScreen({Key? key}) : super(key: key);

  @override
  State<CommunityMentorScreen> createState() => _CommunityMentorScreenState();
}

class _CommunityMentorScreenState extends State<CommunityMentorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
        actions: [
          PopMenuButtonWidget(),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardCommunity(
                      title: "FlutterXperience Community",
                      imagePath: 'assets/Handoff/CommunityLogo/Flutter.png',
                    ),
                    CardCommunity(
                      title: "UXElevation Network",
                      imagePath: 'assets/Handoff/CommunityLogo/UIUX.png',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardCommunity(
                      title: "KotlinKoders Community",
                      imagePath: 'assets/Handoff/CommunityLogo/Kotlin.png',
                    ),
                    CardCommunity(
                      title: "Python Community",
                      imagePath: 'assets/Handoff/CommunityLogo/Python.png',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardCommunity(
                      title: "HTMLCSSInnovate Network",
                      imagePath: 'assets/Handoff/CommunityLogo/HTMLCSS.png',
                    ),
                    CardCommunity(
                      title: "ReactCatalyst Developers",
                      imagePath: 'assets/Handoff/CommunityLogo/JS.png',
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
