
import 'package:final_project/models/product_model.dart';

class CartModel {
  int id;
  int userId;
  ProductModel product;
  int productQuantity;


  CartModel({this.id, this.userId, this.product,this.productQuantity});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'],
      userId: json['userId'],
      product : ProductModel.fromJson(json['product']),
      productQuantity : json['productQuantity']
      );

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "userId": this.userId,
    "product":this.product.toJson(),
    "productQuantity" : this.productQuantity
  };
}
