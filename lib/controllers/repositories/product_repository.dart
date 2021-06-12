import 'package:dio/dio.dart';
import 'package:final_project/controllers/repositories/my_config.dart';
import 'package:final_project/models/favourites_model.dart';
import 'package:final_project/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/models/tag_model.dart';

class ProductRepository {
  Dio _dio;
  ProductRepository(){
    _dio = MyConfig.dio;
  }

  Future<Either<String, bool>> addProduct(ProductModel product) async {
    try {
      await _dio.post('/products', data: product.toJson());
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> updateProduct(ProductModel product) async {
    try {
      await _dio.put('/products/${product.id}', data: product.toJson());
      return right(true);
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

  Future<Either<String, bool>> isExistInFavourite(int userId , int productId) async {
    try {
      Response<dynamic> result = await _dio.get("/favourites?userId=$userId&productId=$productId");
      return right(result.data.length > 0);
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

  Future<Either<String , ProductModel>> getProductById(int productId) async {
    try {
      Response<dynamic> result = await _dio.get('/products/$productId');
      if(result.data.length > 0){
        print(result.data);
        return right(result.data);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> productRemove(int id) async {
    try {
      await _dio.delete('/products/$id');
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }


  Future<Either<String , List<TagModel>>> searchTags(String param) async {
    try {
      Response<dynamic> result = await _dio.get('/tags?q=$param');
      if(result.data.length > 0){
        var tagModels = result.data.map<TagModel>((item) {
          TagModel tagModel = TagModel.fromJson(item);
          return tagModel;
        }).toList();
        return right(tagModels);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> addFavourite(FavouriteModel favourite) async {
    try{
      await _dio.post('/favourites', data: favourite.toJson());
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> removeFavourite(int id) async {
    try {
      await _dio.delete('/favourites/$id');
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<FavouriteModel>>> getFavourites() async {
    try {
      Response<dynamic> result = await _dio.get('/favourites');
      if (result.data.length > 0) {
        var favouriteModels = result.data.map<FavouriteModel>((item) {
          FavouriteModel favouriteModel = FavouriteModel.fromJson(item);
          return favouriteModel;
        }).toList();
        return right(favouriteModels);
      } else {
        return result.data;
      }
    } catch (e) {
      return left(e.toString());
    }
  }

}