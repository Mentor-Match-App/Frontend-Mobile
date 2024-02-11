import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/service/service_SMP_mentor.dart';

import 'package:mentormatch_apps/mentor/model/category_SMP_model.dart';

class MentorKuliah extends StatefulWidget {
  @override
  _MentorKuliahState createState() => _MentorKuliahState();
}

class _MentorKuliahState extends State<MentorKuliah> {
  late Future<SMP> futureSMPData;

  @override
  void initState() {
    super.initState();
    futureSMPData = SMPServices().getSMPData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mentors List")),
      body: FutureBuilder<SMP>(
        future: futureSMPData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            // Filter mentor berdasarkan kategori "Bahasa" jika kelas tersedia
            final mentorsWithLanguageCategory = snapshot.data!.mentors!
                .where((mentor) => mentor.mentorClass?.category == "Bahasa")
                .toList();

            return ListView.builder(
              itemCount: mentorsWithLanguageCategory.length,
              itemBuilder: (context, index) {
                final mentor = mentorsWithLanguageCategory[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: mentor.photoUrl != null
                          ? Image.network(mentor.photoUrl!)
                          : Image.asset(
                              'assets/Handoff/ilustrator/profile.png'), // Ganti dengan placeholder jika perlu
                      title: Text(mentor.name ?? "No Name"),
                      subtitle: Text(mentor.about ?? "No About"),
                    ),
                    // Tampilkan terms untuk kelas "Bahasa"
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mentor.mentorClass?.category == "Bahasa"
                            ? mentor.mentorClass!.terms!.map((term) {
                                return Text("- $term");
                              }).toList()
                            : [],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
