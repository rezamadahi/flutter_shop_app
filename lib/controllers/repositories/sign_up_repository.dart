import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/repositories/my_config.dart';
import 'package:final_project/models/user_model.dart';
import 'package:dio/dio.dart';

class SignUpRepository {
  Dio _dio;
  SignUpRepository(){
    _dio = MyConfig.dio;
  }

  Future<Either<String, bool>> addUser(UserModel user) async {
    try{
      await _dio.post('/users',data: user.toJson());
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> updateUser(UserModel user) async {
    try{
      await _dio.put('/users/${user.id}' , data: user.toJson());
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}