
import 'package:final_project/models/product_model.dart';

class FavouriteModel {
  int id;
  int userId;
  ProductModel product;

  FavouriteModel({this.id, this.userId, this.product});

  factory FavouriteModel.fromJson(Map<String , dynamic> json) => FavouriteModel(
    id : json['id'],
    userId: json['userId'],
    product: ProductModel.fromJson(json['product']),
  );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "userId": this.userId,
    "product": this.product.toJson(),
  };
}