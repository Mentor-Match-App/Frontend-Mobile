// To parse this JSON data, do
//
//     final kuliah = kuliahFromMap(jsonString);

import 'dart:convert';

Kuliah kuliahFromMap(String str) => Kuliah.fromMap(json.decode(str));

String kuliahToMap(Kuliah data) => json.encode(data.toMap());

class Kuliah {
  bool? error;
  String? message;
  List<MentorKuliah>? mentors;

  Kuliah({
    this.error,
    this.message,
    this.mentors,
  });

  factory Kuliah.fromMap(Map<String, dynamic> json) => Kuliah(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null
            ? []
            : List<MentorKuliah>.from(
                json["mentors"]!.map((x) => MentorKuliah.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null
            ? []
            : List<dynamic>.from(mentors!.map((x) => x.toMap())),
      };
}

class MentorKuliah {
  String? id;
  String? userType;
  String? email;
  String? name;
  List<String>? skills;
  String? gender;
  String? location;
  String? linkedin;
  String? portofolio;
  String? photoUrl;
  String? about;
  Class? mentorClass;
  List<MentorReview>? mentorReviews;
  List<Experience>? experiences;

  MentorKuliah({
    this.id,
    this.userType,
    this.email,
    this.name,
    this.skills,
    this.gender,
    this.location,
    this.linkedin,
    this.portofolio,
    this.photoUrl,
    this.about,
    this.mentorClass,
    this.mentorReviews,
    this.experiences,
  });

  factory MentorKuliah.fromMap(Map<String, dynamic> json) => MentorKuliah(
        id: json["id"],
        userType: json["userType"],
        email: json["email"],
        name: json["name"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        gender: json["gender"],
        location: json["location"],
        linkedin: json["linkedin"],
        portofolio: json["portofolio"],
        photoUrl: json["photoUrl"],
        about: json["about"],
        mentorClass:
            json["class"] == null ? null : Class.fromMap(json["class"]),
        mentorReviews: json["mentorReviews"] == null
            ? []
            : List<MentorReview>.from(
                json["mentorReviews"]!.map((x) => MentorReview.fromMap(x))),
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType,
        "email": email,
        "name": name,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "gender": gender,
        "location": location,
        "linkedin": linkedin,
        "portofolio": portofolio,
        "photoUrl": photoUrl,
        "about": about,
        "class": mentorClass?.toMap(),
        "mentorReviews": mentorReviews == null
            ? []
            : List<dynamic>.from(mentorReviews!.map((x) => x)),
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toMap())),
      };
}

class Experience {
  String? id;
  String? userId;
  bool? isCurrentJob;
  String? company;
  String? jobTitle;

  Experience({
    this.id,
    this.userId,
    this.isCurrentJob,
    this.company,
    this.jobTitle,
  });

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
        id: json["id"],
        userId: json["userId"],
        isCurrentJob: json["isCurrentJob"],
        company: json["company"],
        jobTitle: json["jobTitle"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "isCurrentJob": isCurrentJob,
        "company": company,
        "jobTitle": jobTitle,
      };
}

class Class {
  String? id;
  String? mentorId;
  String? educationLevel;
  String? category;
  String? name;
  String? description;
  List<String>? terms;
  int? price;
  bool? isActive;
  bool? isAvailable;
  bool? isVerified;
  int? durationInDays;
  dynamic zoomLink;

  Class({
    this.id,
    this.mentorId,
    this.educationLevel,
    this.category,
    this.name,
    this.description,
    this.terms,
    this.price,
    this.isActive,
    this.isAvailable,
    this.isVerified,
    this.durationInDays,
    this.zoomLink,
  });

  factory Class.fromMap(Map<String, dynamic> json) => Class(
        id: json["id"],
        mentorId: json["mentorId"],
        educationLevel: json["educationLevel"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        terms: json["terms"] == null
            ? []
            : List<String>.from(json["terms"]!.map((x) => x)),
        price: json["price"],
        isActive: json["isActive"],
        isAvailable: json["isAvailable"],
        isVerified: json["isVerified"],
        durationInDays: json["durationInDays"],
        zoomLink: json["zoomLink"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "mentorId": mentorId,
        "educationLevel": educationLevel,
        "category": category,
        "name": name,
        "description": description,
        "terms": terms == null ? [] : List<dynamic>.from(terms!.map((x) => x)),
        "price": price,
        "isActive": isActive,
        "isAvailable": isAvailable,
        "isVerified": isVerified,
        "durationInDays": durationInDays,
        "zoomLink": zoomLink,
      };
}

class MentorReview {
  String? id;
  String? reviewerId;
  String? mentorId;
  String? content;

  MentorReview({
    this.id,
    this.reviewerId,
    this.mentorId,
    this.content,
  });

  factory MentorReview.fromMap(Map<String, dynamic> json) => MentorReview(
        id: json["id"],
        reviewerId: json["reviewerId"],
        mentorId: json["mentorId"],
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "reviewerId": reviewerId,
        "mentorId": mentorId,
        "content": content,
      };
}
