import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/community_model.dart';
import 'package:mentormatch_apps/mentee/service/community_service.dart';
import 'package:mentormatch_apps/widget/card_community.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityMentorScreen extends StatefulWidget {
  CommunityMentorScreen({Key? key}) : super(key: key);

  @override
  State<CommunityMentorScreen> createState() => _CommunityMentorScreenState();
}

class _CommunityMentorScreenState extends State<CommunityMentorScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  final CommunityService communityService = CommunityService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: FutureBuilder<CommunityModels>(
        future: communityService.fetchCommunities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final communityList = snapshot.data?.communities;
            if (communityList == null || communityList.isEmpty) {
              return const Center(
                child: Text('No communities available.'),
              );
            } else {
              return Column(
                children: [
                  SearchBarWidget(
                    title: "Search by name,company, role ",
                    onPressed: () {},
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: communityList.length,
                      itemBuilder: (context, index) {
                        var community = communityList[index];
                        return Column(
                          children: [
                            CardCommunity(
                              title: community.name ?? '',
                              imagePath: community.imageUrl ?? '',
                              onPressed: () {
                                final communityUrl = community.link ?? '';
                                _launchURL(communityUrl);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            }
          }
        },
      ),
    );
  }
}
