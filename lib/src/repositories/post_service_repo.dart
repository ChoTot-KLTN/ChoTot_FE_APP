import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<PostModel>> getAllPost() async {
    http.Response result = await BaseRepository().get(ApiGateway.getAllPost);
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data']['posts'];
      var list = PostModel.fromJsonList(data);
      return list;
    }
    return [];
  }

  Future<List<PostModel>> getAllPostAuth(){
    
  }
}
