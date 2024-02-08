// To parse this JSON data, do
//
//     final mentorModel = mentorModelFromMap(jsonString);

import 'dart:convert';

MentorModel mentorModelFromMap(String str) => MentorModel.fromMap(json.decode(str));

String mentorModelToMap(MentorModel data) => json.encode(data.toMap());

class MentorModel {
    bool? error;
    String? message;
    List<Mentor>? mentors;

    MentorModel({
        this.error,
        this.message,
        this.mentors,
    });

    factory MentorModel.fromMap(Map<String, dynamic> json) => MentorModel(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null ? [] : List<Mentor>.from(json["mentors"]!.map((x) => Mentor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null ? [] : List<dynamic>.from(mentors!.map((x) => x.toMap())),
    };
}

class Mentor {
    String? id;
    String? userType;
    String? email;
    String? name;
    String? gender;
    List<String>? skills;
    String? location;
    String? linkedin;
    String? portfolio;
    String? photoUrl;
    String? about;
    List<Experience>? experience;
    List<Community>? community;
    List<dynamic>? session;
    List<dynamic>? historySession;
    List<dynamic>? classes;
    List<dynamic>? transactionsMentor;
    List<dynamic>? transactionsMentee;
    List<dynamic>? transaction;

    Mentor({
        this.id,
        this.userType,
        this.email,
        this.name,
        this.gender,
        this.skills,
        this.location,
        this.linkedin,
        this.portfolio,
        this.photoUrl,
        this.about,
        this.experience,
        this.community,
        this.session,
        this.historySession,
        this.classes,
        this.transactionsMentor,
        this.transactionsMentee,
        this.transaction,
    });

    factory Mentor.fromMap(Map<String, dynamic> json) => Mentor(
        id: json["id"],
        userType: json["user_type"],
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        location: json["location"],
        linkedin: json["linkedin"],
        portfolio: json["portfolio"],
        photoUrl: json["photo_url"],
        about: json["about"],
        experience: json["Experience"] == null ? [] : List<Experience>.from(json["Experience"]!.map((x) => Experience.fromMap(x))),
        community: json["Community"] == null ? [] : List<Community>.from(json["Community"]!.map((x) => Community.fromMap(x))),
        session: json["Session"] == null ? [] : List<dynamic>.from(json["Session"]!.map((x) => x)),
        historySession: json["HistorySession"] == null ? [] : List<dynamic>.from(json["HistorySession"]!.map((x) => x)),
        classes: json["Classes"] == null ? [] : List<dynamic>.from(json["Classes"]!.map((x) => x)),
        transactionsMentor: json["TransactionsMentor"] == null ? [] : List<dynamic>.from(json["TransactionsMentor"]!.map((x) => x)),
        transactionsMentee: json["TransactionsMentee"] == null ? [] : List<dynamic>.from(json["TransactionsMentee"]!.map((x) => x)),
        transaction: json["Transaction"] == null ? [] : List<dynamic>.from(json["Transaction"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_type": userType,
        "email": email,
        "name": name,
        "gender": gender,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "location": location,
        "linkedin": linkedin,
        "portfolio": portfolio,
        "photo_url": photoUrl,
        "about": about,
        "Experience": experience == null ? [] : List<dynamic>.from(experience!.map((x) => x.toMap())),
        "Community": community == null ? [] : List<dynamic>.from(community!.map((x) => x.toMap())),
        "Session": session == null ? [] : List<dynamic>.from(session!.map((x) => x)),
        "HistorySession": historySession == null ? [] : List<dynamic>.from(historySession!.map((x) => x)),
        "Classes": classes == null ? [] : List<dynamic>.from(classes!.map((x) => x)),
        "TransactionsMentor": transactionsMentor == null ? [] : List<dynamic>.from(transactionsMentor!.map((x) => x)),
        "TransactionsMentee": transactionsMentee == null ? [] : List<dynamic>.from(transactionsMentee!.map((x) => x)),
        "Transaction": transaction == null ? [] : List<dynamic>.from(transaction!.map((x) => x)),
    };
}

class Community {
    String? id;
    String? adminId;
    String? name;
    String? link;
    String? image;

    Community({
        this.id,
        this.adminId,
        this.name,
        this.link,
        this.image,
    });

    factory Community.fromMap(Map<String, dynamic> json) => Community(
        id: json["id"],
        adminId: json["adminId"],
        name: json["name"],
        link: json["link"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "adminId": adminId,
        "name": name,
        "link": link,
        "image": image,
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
