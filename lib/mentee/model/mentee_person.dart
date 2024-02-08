class MentorExampleModel {
  final String id; // Ubah tipe dari int ke String
  final String name;
  final String email;
  final String? photoUrl;
  final String? userType;
  final List<String>? skills;
  final String? location;
  final String? about;

  MentorExampleModel({
    required this.id, // `id` sekarang sebagai String
    required this.name,
    required this.email,
    this.photoUrl,
    this.userType,
    this.skills,
    this.location,
    this.about,
  });
factory MentorExampleModel.fromJson(Map<String, dynamic> json) {
  return MentorExampleModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    photoUrl: json['photo_url'], // Perhatikan perbedaan penamaan
    userType: json['user_type'],
    skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
    location: json['location'],
    about: json['about'],
  );
}

  // factory Person.fromJson(Map<String, dynamic> json) {
  //   return Person(
  //     id: json['id'], // Tidak perlu konversi
  //     name: json['name'],
  //     email: json['email'],
  //     photoUrl: json['photoUrl'],
  //     userType: json['userType'],
  //     skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
  //     location: json['location'],
  //     about: json['about'],
  //   );
  // }
}
