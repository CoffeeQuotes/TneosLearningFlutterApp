import 'dart:convert';

Paidlive paidliveFromJson(String str) => Paidlive.fromJson(json.decode(str));

String paidliveToJson(Paidlive data) => json.encode(data.toJson());

class Paidlive {
  Paidlive({
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
    this.paidliveClass,
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
  String board;
  int paidliveClass;
  String subject;

  factory Paidlive.fromJson(Map<String, dynamic> json) => Paidlive(
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
    board: json["board"],
    paidliveClass: json["class"],
    subject: json["subject"],
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
    "board": board,
    "class": paidliveClass,
    "subject": subject,
  };
}