import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/service/example_mentors/service_kuliah_mentor.dart';
import 'package:mentormatch_apps/mentor/model/category_kuliah_model.dart';

class MentorKuliah extends StatefulWidget {
  @override
  _MentorKuliahState createState() => _MentorKuliahState();
}

class _MentorKuliahState extends State<MentorKuliah> {
  late Future<Kuliah> futureKuliahData;

  @override
  void initState() {
    super.initState();
    futureKuliahData = KuliahService().getKuliahData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Mentors List")),
        body: FutureBuilder<Kuliah>(
          future: futureKuliahData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              // Penyaringan mentor berdasarkan kategori "Matematika"
              final mentorsWithMathCategory = snapshot.data!.mentors!
                  .where((mentor) => mentor.classes!
                      .any((kelas) => kelas.category == "Matematika"))
                  .toList();

              return ListView.builder(
                itemCount: mentorsWithMathCategory.length,
                itemBuilder: (context, index) {
                  final mentor = mentorsWithMathCategory[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(mentor.name ?? "No Name"),
                        subtitle: Text(mentor.about ?? "No About"),
                        leading: mentor.photoUrl != null
                            ? Image.network(mentor.photoUrl!)
                            : null,
                      ),

                      ///untuk menampilkan terms yang ada di kelas
                    ],
                  );
                },
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ));
  }
}
