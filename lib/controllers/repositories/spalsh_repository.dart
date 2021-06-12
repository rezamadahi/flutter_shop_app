import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/repositories/my_config.dart';
import 'package:final_project/models/user_model.dart';
import 'package:dio/dio.dart';


class SplashRepository {
  Dio _dio;
  SplashRepository(){
    _dio = MyConfig.dio;
  }

  Future<Either<String, bool>> isAdminExist() async {
    try{
      Response<dynamic> result = await _dio.get('/users?userName="admin"');
      return right(result.data.length > 0);
    }catch(e){
      return left(e.toString());
    }

  }


  Future<Either<String, bool>> addAdmin(UserModel adminUser) async {
    try{
      await _dio.post('/users',data: adminUser.toJson());
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}