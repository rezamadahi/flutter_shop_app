import 'package:dartz/dartz.dart';
import 'package:final_project/controllers/repositories/my_config.dart';
import 'package:final_project/models/user_model.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  Dio _dio;
  LoginRepository(){
    _dio = MyConfig.dio;
  }

  Future<Either<String, UserModel>> userValidate(String username,String password) async {
    try{
      Response<dynamic> result = await _dio.get('/users?username=$username&password=$password');
      if(result.data.length > 0){
        return right(UserModel.fromJson(result.data[0]));
      }else{
        return result.data;
      }
    }catch(e){
      return left(e.toString());
    }
  }
}