import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/service/service_Kuliah.dart';
import 'package:mentormatch_apps/mentor/model/category_Kuliah_model.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class DesignKuliahScreen extends StatefulWidget {
  DesignKuliahScreen({Key? key}) : super(key: key);

  @override
  State<DesignKuliahScreen> createState() => _DesignKuliahScreenState();
}

class _DesignKuliahScreenState extends State<DesignKuliahScreen> {
late Future<Kuliah> futureKuliahData;

  @override
  void initState() {
    super.initState();
    futureKuliahData = KuliahServices().getKuliahData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Kuliah>(
      future: futureKuliahData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final mentorsWithLanguageCategory = snapshot.data!.mentors!
              .where((mentor) => mentor.mentorClass?.category == "Desain")
              .toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              childAspectRatio: 3 / 5, 
              crossAxisSpacing: 2,
              mainAxisSpacing: 2, 
            ),
            itemCount: mentorsWithLanguageCategory.length,
            itemBuilder: (context, index) {
              final mentor = mentorsWithLanguageCategory[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Menyediakan default Experience jika tidak ditemukan
              );

              return CardItemMentor(
                 onPressesd: () {},
                imagePath:
                    mentor.photoUrl ?? 'assets/Handoff/ilustrator/profile.png',
                name: mentor.name ?? 'No Name',
                job: currentExperience.jobTitle ?? '',
                company: currentExperience.company ?? 'Placeholder Company',
              );
            },
            shrinkWrap: true,
            physics:
                ScrollPhysics(), // Mengizinkan scroll jika di dalam SingleChildScrollView
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}

