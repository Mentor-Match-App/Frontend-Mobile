// To parse this JSON data, do
//
//     final mentee = menteeFromMap(jsonString);

import 'dart:convert';

Mentee menteeFromMap(String str) => Mentee.fromMap(json.decode(str));

String menteeToMap(Mentee data) => json.encode(data.toMap());

class Mentee {
  bool? error;
  String? message;
  User? user;

  Mentee({
    this.error,
    this.message,
    this.user,
  });

  factory Mentee.fromMap(Map<String, dynamic> json) => Mentee(
        error: json["error"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "user": user?.toMap(),
      };
}

class User {
  String? id;
  String? userType;
  String? email;
  String? name;
  List<String>? skills;
  dynamic gender;
  String? location;
  String? linkedin;
  dynamic portofolio;
  String? photoUrl;
  String? about;
  List<Experience>? experiences;
  List<dynamic>? communities;
  dynamic userClass;
  List<dynamic>? session;
  List<Participant>? participant;
  List<Transaction>? transactions;

  User({
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
    this.experiences,
    this.communities,
    this.userClass,
    this.session,
    this.participant,
    this.transactions,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
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
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromMap(x))),
        communities: json["communities"] == null
            ? []
            : List<dynamic>.from(json["communities"]!.map((x) => x)),
        userClass: json["class"],
        session: json["session"] == null
            ? []
            : List<dynamic>.from(json["session"]!.map((x) => x)),
        participant: json["participant"] == null
            ? []
            : List<Participant>.from(
                json["participant"]!.map((x) => Participant.fromMap(x))),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
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
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toMap())),
        "communities": communities == null
            ? []
            : List<dynamic>.from(communities!.map((x) => x)),
        "class": userClass,
        "session":
            session == null ? [] : List<dynamic>.from(session!.map((x) => x)),
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x.toMap())),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
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

class Participant {
  String? sessionId;
  String? userId;

  Participant({
    this.sessionId,
    this.userId,
  });

  factory Participant.fromMap(Map<String, dynamic> json) => Participant(
        sessionId: json["sessionId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "sessionId": sessionId,
        "userId": userId,
      };
}

class Transaction {
  String? id;
  String? classId;
  String? createdAt;
  int? uniqueCode;
  String? paymentStatus;
  String? expired;
  String? userId;

  Transaction({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
    this.paymentStatus,
    this.expired,
    this.userId,
  });

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        classId: json["classId"],
        createdAt: json["createdAt"],
        uniqueCode: json["uniqueCode"],
        paymentStatus: json["paymentStatus"],
        expired: json["expired"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "classId": classId,
        "createdAt": createdAt,
        "uniqueCode": uniqueCode,
        "paymentStatus": paymentStatus,
        "expired": expired,
        "userId": userId,
      };
}
