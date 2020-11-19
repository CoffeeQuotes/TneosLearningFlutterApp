// To parse this JSON data, do
//
//     final lives = livesFromJson(jsonString);

import 'dart:convert';

List<Lives> livesFromJson(String str) => List<Lives>.from(json.decode(str).map((x) => Lives.fromJson(x)));

String livesToJson(List<Lives> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lives {
  Lives({
    this.id,
    this.title,
    this.status,
    this.image,
    this.slug,
    this.embedCode,
    this.description,
    this.featured,
    this.metaDescription,
    this.metaKeywords,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.board,
    this.lifeClass,
    this.subject,
  });

  int id;
  String title;
  String status;
  String image;
  String slug;
  String embedCode;
  String description;
  int featured;
  String metaDescription;
  String metaKeywords;
  DateTime createdAt;
  DateTime updatedAt;
  String categoryId;
  String board;//Board board;
  int lifeClass;
  String subject; //Subject subject;

  factory Lives.fromJson(Map<String, dynamic> json) => Lives(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    image: json["image"],
    slug: json["slug"],
    embedCode: json["embed_code"],
    description: json["description"],
    featured: json["featured"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    categoryId: json["category_id"],
    board: json["board"], //boardValues.map[json["board"]],
    lifeClass: json["class"],
    subject: json["subject"] //subjectValues.map[json["subject"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "image": image,
    "slug": slug,
    "embed_code": embedCode,
    "description": description,
    "featured": featured,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category_id": categoryId,
    "board": board, //boardValues.reverse[board],
    "class": lifeClass,
    "subject": subject, //subjectValues.reverse[subject],
  };
}

// enum Board { CBSE, ODISHA, BIHAR }
//
// final boardValues = EnumValues({
//   "Bihar": Board.BIHAR,
//   "CBSE": Board.CBSE,
//   "Odisha": Board.ODISHA
// });
//
// enum Subject { ENGLISH, MATHEMATICS, SCIENCE, SOCIAL_SCIENCE }
//
// final subjectValues = EnumValues({
//   "English": Subject.ENGLISH,
//   "Mathematics": Subject.MATHEMATICS,
//   "Science": Subject.SCIENCE,
//   "Social Science": Subject.SOCIAL_SCIENCE
// });

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
