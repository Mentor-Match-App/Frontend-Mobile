import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentormatch_apps/mentee/model/myClass_model.dart';
import 'package:mentormatch_apps/mentee/service/myClassService/myClass_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  Future<List<ParticipantMyClass>>? _userData;

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserSessions();
  }
//// link zoom akses///
    _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParticipantMyClass>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<ParticipantMyClass> participants = snapshot.data!;
           return SingleChildScrollView(
            child: Column(
              children: participants.map((participant) {
                final session = participant.session!;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  session.mentor!.photoUrl.toString(),
                                  fit: BoxFit.cover,
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
                                      session.category ?? '',
                                      style: FontFamily().boldText,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                     session.dateTime.toString(),
                                      style: FontFamily().regularText,
                                    ),
                                    Text(
                                      'Mentor ${session.mentor!.name}',
                                      style: FontFamily().regularText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const SizedBox(
                            width: 12,
                          ),
                          Padding(
                                                      padding:
                            const EdgeInsets.only(right: 12.0, top: 8.0),
                                                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ColorStyle().primaryColors,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                primary: ColorStyle().whiteColors,
                              ),
                              onPressed: () {
                            final zommLink = session.zoomLink ?? '';
                            _launchURL(zommLink);
                          },
                              icon: Icon(Icons.link),
                              label: Text('Link Zoom',
                                  style: FontFamily().regularText.copyWith(
                                        color: ColorStyle().whiteColors,
                                      )),
                            ),
                          ),
                                                      ),
                                                    ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return Center(child: Text('No data'));
        }
      },
    );
  }
}