
import 'dart:convert';

List<Packages> packagesFromJson(String str) => List<Packages>.from(json.decode(str).map((x) => Packages.fromJson(x)));

String packagesToJson(List<Packages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Packages {
  Packages({
    this.id,
    this.parentId,
    this.order,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.description,
    this.amount,
    this.packageClass,
    this.board,
    this.subject,
  });

  int id;
  dynamic parentId;
  int order;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String description;
  int amount;
  int packageClass;
  String board;
  String subject;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    id: json["id"],
    parentId: json["parent_id"],
    order: json["order"],
    name: json["name"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"],
    description: json["description"],
    amount: json["amount"],
    packageClass: json["class"],
    board: json["board"], //boardValues.map[json["board"]],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "order": order,
    "name": name,
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "image": image,
    "description": description,
    "amount": amount,
    "class": packageClass,
    "board": board, //boardValues.reverse[board],
    "subject": subject,
  };
}

//enum Board { CBSE, ODISHA, BIHAR }
//
// final boardValues = EnumValues({
//   "Bihar": Board.BIHAR,
//   "CBSE": Board.CBSE,
//   "Odisha": Board.ODISHA
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
