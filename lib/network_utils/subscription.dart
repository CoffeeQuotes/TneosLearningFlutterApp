// To parse this JSON data, do
//
//     final subscriptions = subscriptionsFromJson(jsonString);

import 'dart:convert';

List<Subscriptions> subscriptionsFromJson(String str) =>
    List<Subscriptions>.from(
        json.decode(str).map((x) => Subscriptions.fromJson(x)));

String subscriptionsToJson(List<Subscriptions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscriptions {
  Subscriptions({
    this.id,
    this.title,
    this.amount,
    this.paymentId,
    this.razorpayId,
    this.paymentDone,
    this.categoryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  int amount;
  String paymentId;
  String razorpayId;
  int paymentDone;
  int categoryId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        paymentId: json["payment_id"] == null ? null : json["payment_id"],
        razorpayId: json["razorpay_id"] == null ? null : json["razorpay_id"],
        paymentDone: json["payment_done"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "payment_id": paymentId == null ? null : paymentId,
        "razorpay_id": razorpayId == null ? null : razorpayId,
        "payment_done": paymentDone,
        "category_id": categoryId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
