import 'package:flutter/material.dart';
import 'package:mentormatch_apps/widget/card_community.dart';
import 'package:mentormatch_apps/widget/navbar.dart';

class CommunityScreen extends StatefulWidget {
  CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
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
                Container(
                    constraints:
                        BoxConstraints.expand(), // or set a specific size
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing:
                            10.0, // Optional, add spacing between columns
                        mainAxisSpacing:
                            10.0, // Optional, add spacing between rows
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              CardCommunity(
                                imagePath:
                                    'assets/Handoff/CommunityLogo/Flutter.png',
                              ),
                            ],
                          ),
                        ),
                        // Add more items as needed
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
