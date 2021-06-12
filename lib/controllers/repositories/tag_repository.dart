import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/models/tag_model.dart';
import 'my_config.dart';

class TagRepository {
  Dio _dio;

  TagRepository() {
    _dio = MyConfig.dio;
  }

  Future<Either<String, bool>> addTag(TagModel tag) async {
    try {
      await _dio.post('/tags', data: tag.toJson());
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> updateTag(TagModel tag) async {
    try {
      await _dio.put('/tags/${tag.id}', data: tag.toJson());
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<TagModel>>> getTags() async {
    try {
      Response<dynamic> result = await _dio.get('/tags');
      if (result.data.length > 0) {
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

  Future<Either<String, bool>> tagRemove(int id) async {
    try {
      await _dio.delete('/tags/$id');
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }
}
