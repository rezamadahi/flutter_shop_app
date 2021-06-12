import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/repositories/my_config.dart';
import 'package:final_project/models/favourites_model.dart';

class FavouritesRepository {
  Dio _dio;
  FavouritesRepository(){
    _dio = MyConfig.dio;
  }

  Future<Either<String, bool>> addFavourite(FavouriteModel favourite) async {
    try{
      await _dio.post('/favourites', data: favourite.toJson());
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String, List<FavouriteModel>>> getFavourites() async {
    try {
      Response<dynamic> result = await _dio.get('/favourites');
      if (result.data.length > 0) {
        List<FavouriteModel> favouriteModels = result.data.map<FavouriteModel>((item) {
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

  Future<Either<String , List<FavouriteModel>>> searchFavourites(String param) async {
    try {
      Response<dynamic> result = await _dio.get('/favourites?q=$param');
      if(result.data.length > 0){
        List<FavouriteModel> favouriteModels = result.data.map<FavouriteModel>((item) {
          var favouriteModel = FavouriteModel.fromJson(item);
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

  Future<Either<String, bool>> removeFavourite(int id) async {
    try {
      await _dio.delete('/favourites/$id');
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

}