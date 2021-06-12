import 'dart:convert';
import 'package:final_project/models/tag_model.dart';

class ProductModel {
  int id;
  String title;
  String description;
  int price;
  String imageUrl;
  int quantity;
  List<TagModel> productTags;
  bool isActive;

  ProductModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.quantity,
      this.productTags,
      this.isActive});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        // productIds:json['productIds'].cast<int>(),
        quantity: json["quantity"],
        productTags: (json['productTags'] as List<dynamic>)
            .map((e) => TagModel.fromJson(e))
            .toList(),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "title": this.title,
        "description": this.description,
        "price": this.price,
        "imageUrl": this.imageUrl,
        "quantity": this.quantity,
        "productTags": this.productTags.map((e) => e.toJson()).toList(),
        "isActive": this.isActive,
      };
}
