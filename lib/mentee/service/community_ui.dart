import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/community_model.dart';
import 'package:mentormatch_apps/mentee/service/community_service.dart';

class CommunityListScreen extends StatefulWidget {
  @override
  _CommunityListScreenState createState() => _CommunityListScreenState();
}

class _CommunityListScreenState extends State<CommunityListScreen> {
  final CommunityService communityService = CommunityService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Communities'),
      ),
      body: FutureBuilder<CommunityModels>(
        future: communityService.fetchCommunities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final communityList = snapshot.data?.communities;
            if (communityList == null || communityList.isEmpty) {
              return Center(
                child: Text('No communities available.'),
              );
            } else {
              return ListView.builder(
                itemCount: communityList.length,
                itemBuilder: (context, index) {
                  var community = communityList[index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: community.imageUrl ?? '',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(community.name ?? ''),
                    subtitle: Text(community.link ?? ''),
                    // Anda dapat menambahkan lebih banyak informasi komunitas sesuai kebutuhan
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
