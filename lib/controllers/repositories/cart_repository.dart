import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/models/cart_model.dart';
import 'package:final_project/models/product_model.dart';
import 'my_config.dart';

class CartRepository{
  Dio _dio;
  CartRepository() {
    _dio = MyConfig.dio;
  }

  Future<Either<String, bool>> addCart(CartModel cart) async {
    try {
      await _dio.post('/cart', data: cart.toJson());
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> updateCart(CartModel cart) async {
    try {
      await _dio.put('/cart/${cart.id}', data: cart.toJson());
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<CartModel>>> getCarts() async {
    try {
      Response<dynamic> result = await _dio.get('/cart');
      if (result.data.length > 0) {
        List<CartModel> cartModels = result.data.map<CartModel>((item) {
          CartModel cartModel = CartModel.fromJson(item);
          return cartModel;
        }).toList();
        return right(cartModels);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String , List<CartModel>>> searchCart(String param) async {
    try {
      Response<dynamic> result = await _dio.get('/cart?q=$param');
      if(result.data.length > 0){
        var cartModels = result.data.map<CartModel>((item) {
          CartModel cartModel = CartModel.fromJson(item);
          return cartModel;
        }).toList();
        return right(cartModels);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> cartRemove(int id) async {
    try {
      await _dio.delete('/cart/$id');
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      Response<dynamic> result = await _dio.get('/products');
      if (result.data.length > 0) {
        var productModels = result.data.map<ProductModel>((item) {
          ProductModel tagModel = ProductModel.fromJson(item);
          return tagModel;
        }).toList();
        return right(productModels);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String , List<ProductModel>>> searchProducts(String param) async {
    try {
      Response<dynamic> result = await _dio.get('/products?q=$param');
      if(result.data.length > 0){
        var productModels = result.data.map<ProductModel>((item) {
          ProductModel productModel = ProductModel.fromJson(item);
          return productModel;
        }).toList();
        return right(productModels);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> updateProductQuantity(int productId,int quantity) async {
    try {
      await _dio.patch('/products/$productId', data: {"quantity":quantity});
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> isExistInShoppingCart(int userId , int productId) async {
    try {
      Response<dynamic> result = await _dio.get("/cart?userId=$userId&product['id']=$productId");
      return right(result.data.length > 0);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> updateQuantity(int productId,int quantity) async {
    try {
      await _dio.patch('/products/$productId', data: {"quantity":quantity});
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }


}