import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class PostServiceRepository {
  Future<List<PostModel>> getAllPost(
      {int? page, int? limit, int? status}) async {
    // print('request URL: ' +
    //     ApiGateway.getAllPost +
    //     '?status=$status&page=$page&limit=$limit');
    http.Response result = await BaseRepository()
        .get(ApiGateway.getAllPost + '?status=$status&page=$page&limit=$limit');
    print("Status: " + result.statusCode.toString());
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data']['posts'];
      var list = PostModel.fromJsonList(data);
      print("Data Response: " + data.toString());
      return list;
    }
    return [];
  }

  // Future<List<PostModel>> getAllPost1(
  //     {int? page, int? limit, int? status}) async {
  //   print('request URL: ' +
  //       ApiGateway.getAllPost +
  //       '?status=$status&page=$page&limit=$limit');
  //   // http.Response result = await BaseRepository()
  //   //     .get(ApiGateway.getAllPost, '?page=$page&limit=$limit');
  //   http.Response result = await http.get(
  //       Uri.parse(
  //           "https://marketplace-hd.herokuapp.com/post/get-all-post?status=$status&page=0&limit=10"),
  //       headers: {"Content-Type": "application/json"});
  //   if (result.statusCode == 200) {
  //     var data = jsonDecode(result.body)['data']['posts'];
  //     var list = PostModel.fromJsonList(data);
  //     return list;
  //   }
  //   return [];
  // }

  Future<List<PostModel>> getAllPostAuth(
      {required int page, required int limit, required int status}) async {
    print('request URL: ' +
        ApiGateway.getAllPostAuth +
        '?status=$status&page=$page&limit=$limit');
    http.Response result = await BaseRepository().get(
        ApiGateway.getAllPostAuth + '?status=$status&page=$page&limit=$limit');
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data']['posts'];
      var list = PostModel.fromJsonList(data);
      return list;
    }
    return [];
  }

  // Future<http.Response> getPostDetail(String idPost) async {
  //   print('request URL: ' + ApiGateway.getPostDetailAPI + "?postId=$idPost");
  //   http.Response result = await BaseRepository()
  //       .get(ApiGateway.getPostDetailAPI, "?postId=$idPost&");
  //   print("Status: " + result.statusCode.toString());
  //   if (result.statusCode == 200) {
  //     var data = jsonDecode(result.body)['data'];
  //     print(data.toString());
  //   } else {
  //     var data = jsonDecode(result.body)['data'];
  //     print(data.toString());
  //   }
  //   return result;
  // }

  Future<http.Response> getPostDetail1(String idPost) async {
    print('request URL: ' + ApiGateway.getPostDetailAPI + "?postId=$idPost");
    http.Response result = await http.get(
        Uri.parse(
            "https://marketplace111.herokuapp.com/post/get-detail-post?postId=$idPost"),
        headers: {"Content-Type": "application/json"});
    print("Status: " + result.statusCode.toString());
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data'];
      print(data.toString());
    } else {
      var data = jsonDecode(result.body)['data'];
      print(data.toString());
    }
    return result;
  }

  Future<List<PostModel>> getAllPostOvertime(
      {required int page, required int limit, required int status}) async {
    print('request URL: ' +
        ApiGateway.getPostOver +
        '?status=$status&page=$page&limit=$limit');
    http.Response result = await BaseRepository().get(
        ApiGateway.getPostOver + '?status=$status&page=$page&limit=$limit');
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data']['posts'];
      var list = PostModel.fromJsonList(data);
      return list;
    }
    return [];
  }

  Future<http.Response> updateStatusPostAPI(
      {required String idPost, required int status}) async {
    print('request URL: ' + ApiGateway.updatePost + '?postId=$idPost');
    var bodypost = {
      "post": {"status": status},
      "postDetail": {}
    };
    http.Response result = await BaseRepository()
        .put(ApiGateway.updatePost + '?postId=$idPost', bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }

  Future<http.Response> paymentVNPayAPI(
      {required String idPost, required bool isAdver}) async {
    print('request URL: ' + ApiGateway.updatePost + '?postId=$idPost');
    var bodypost = {
      "post": {"isAdvertised": isAdver},
      "postDetail": {}
    };
    http.Response result = await BaseRepository()
        .put(ApiGateway.updatePost + '?postId=$idPost', bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }

  // Gia hạn lại post
  Future<http.Response> reNewPostAPI(
      {required String idPost, required int date}) async {
    print(
        'request URL: ' + ApiGateway.reNewPost + '/postId=$idPost&days=$date');
    var bodypost = {"idPost": idPost, "days": date};
    http.Response result =
        await BaseRepository().put(ApiGateway.reNewPost, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }
}
