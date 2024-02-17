// To parse this JSON data, do
//
//     final mentorClassModel = mentorClassModelFromMap(jsonString);

import 'dart:convert';

MentorClassModel mentorClassModelFromMap(String str) => MentorClassModel.fromMap(json.decode(str));

String mentorClassModelToMap(MentorClassModel data) => json.encode(data.toMap());

class MentorClassModel {
    bool? error;
    String? message;
    List<MentorClass>? mentors;

    MentorClassModel({
        this.error,
        this.message,
        this.mentors,
    });

    factory MentorClassModel.fromMap(Map<String, dynamic> json) => MentorClassModel(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null ? [] : List<MentorClass>.from(json["mentors"]!.map((x) => MentorClass.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null ? [] : List<dynamic>.from(mentors!.map((x) => x.toMap())),
    };
}

class MentorClass {
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
    List<ExperienceMentorClass>? experiences;

    MentorClass({
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

    factory MentorClass.fromMap(Map<String, dynamic> json) => MentorClass(
        id: json["id"],
        userType: json["userType"],
        email: json["email"],
        name: json["name"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        gender: json["gender"],
        location: json["location"],
        linkedin: json["linkedin"],
        portofolio: json["portofolio"],
        photoUrl: json["photoUrl"],
        about: json["about"],
        mentorClass: json["class"] == null ? null : Class.fromMap(json["class"]),
        mentorReviews: json["mentorReviews"] == null ? [] : List<MentorReview>.from(json["mentorReviews"]!.map((x) => MentorReview.fromMap(x))),
        experiences: json["experiences"] == null ? [] : List<ExperienceMentorClass>.from(json["experiences"]!.map((x) => ExperienceMentorClass.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType,
        "email": email,
        "name": name,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "gender": gender,
        "location": location,
        "linkedin": linkedin,
        "portofolio": portofolio,
        "photoUrl": photoUrl,
        "about": about,
        "class": mentorClass?.toMap(),
        "mentorReviews": mentorReviews == null ? [] : List<dynamic>.from(mentorReviews!.map((x) => x.toMap())),
        "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toMap())),
    };
}

class ExperienceMentorClass {
    String? id;
    String? userId;
    bool? isCurrentJob;
    String? company;
    String? jobTitle;

    ExperienceMentorClass({
        this.id,
        this.userId,
        this.isCurrentJob,
        this.company,
        this.jobTitle,
    });

    factory ExperienceMentorClass.fromMap(Map<String, dynamic> json) => ExperienceMentorClass(
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
        terms: json["terms"] == null ? [] : List<String>.from(json["terms"]!.map((x) => x)),
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
    String? reviewer;

    MentorReview({
        this.id,
        this.reviewerId,
        this.mentorId,
        this.content,
        this.reviewer,
    });

    factory MentorReview.fromMap(Map<String, dynamic> json) => MentorReview(
        id: json["id"],
        reviewerId: json["reviewerId"],
        mentorId: json["mentorId"],
        content: json["content"],
        reviewer: json["reviewer"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "reviewerId": reviewerId,
        "mentorId": mentorId,
        "content": content,
        "reviewer": reviewer,
    };
}