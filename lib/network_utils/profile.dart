import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.id,
    this.firstname,
    this.lastname,
    this.mobile,
    this.userId,
    this.image,
    this.profileClass,
    this.schoolName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String firstname;
  String lastname;
  String mobile;
  int userId;
  String image;
  String profileClass;
  String schoolName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    mobile: json["mobile"],
    userId: json["user_id"],
    image: json["image"],
    profileClass: json["class"],
    schoolName: json["school_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "mobile": mobile,
    "user_id": userId,
    "image": image,
    "class": profileClass,
    "school_name": schoolName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
