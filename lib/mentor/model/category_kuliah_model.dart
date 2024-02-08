

import 'dart:convert';

Kuliah kuliahFromMap(String str) => Kuliah.fromMap(json.decode(str));

String kuliahToMap(Kuliah data) => json.encode(data.toMap());

class Kuliah {
    bool? error;
    String? message;
    List<Mentor>? mentors;

    Kuliah({
        this.error,
        this.message,
        this.mentors,
    });

    factory Kuliah.fromMap(Map<String, dynamic> json) => Kuliah(
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
    dynamic portofolio;
    String? photoUrl;
    String? about;
    List<Class>? classes;

    Mentor({
        this.id,
        this.userType,
        this.email,
        this.name,
        this.gender,
        this.skills,
        this.location,
        this.linkedin,
        this.portofolio,
        this.photoUrl,
        this.about,
        this.classes,
    });

    factory Mentor.fromMap(Map<String, dynamic> json) => Mentor(
        id: json["id"],
        userType: json["userType"],
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        location: json["location"],
        linkedin: json["linkedin"],
        portofolio: json["portofolio"],
        photoUrl: json["photoUrl"],
        about: json["about"],
        classes: json["classes"] == null ? [] : List<Class>.from(json["classes"]!.map((x) => Class.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType,
        "email": email,
        "name": name,
        "gender": gender,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "location": location,
        "linkedin": linkedin,
        "portofolio": portofolio,
        "photoUrl": photoUrl,
        "about": about,
        "classes": classes == null ? [] : List<dynamic>.from(classes!.map((x) => x.toMap())),
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
