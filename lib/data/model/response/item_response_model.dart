import 'package:meta/meta.dart';
import 'dart:convert';

class ItemResponseModel {
  final String message;
  final List<Item> item;

  ItemResponseModel({
    required this.message,
    required this.item,
  });

  ItemResponseModel copyWith({
    String? message,
    List<Item>? item,
  }) =>
      ItemResponseModel(
        message: message ?? this.message,
        item: item ?? this.item,
      );

  factory ItemResponseModel.fromJson(String str) => ItemResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemResponseModel.fromMap(Map<String, dynamic> json) => ItemResponseModel(
    message: json["message"],
    item: List<Item>.from(json["item"].map((x) => Item.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "item": List<dynamic>.from(item.map((x) => x.toMap())),
  };
}

class Item {
  final int id;
  final String name;
  final String price;
  final String image;
  final int subcategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.subcategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  Item copyWith({
    int? id,
    String? name,
    String? price,
    String? image,
    int? subcategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        image: image ?? this.image,
        subcategoryId: subcategoryId ?? this.subcategoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    subcategoryId: json["subcategory_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "subcategory_id": subcategoryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
