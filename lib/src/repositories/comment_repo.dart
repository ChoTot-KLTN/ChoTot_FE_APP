import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/comment_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Future<http.Response> registerComment(
      {required String idPost, required String text}) async {
    var body = {'postId': idPost, 'text': text};
    print('Request: ' + ApiGateway.createComment);
    http.Response response =
        await BaseRepository().post(ApiGateway.createComment, body);
    print('response StatusCode: ' + response.statusCode.toString());
    return response;
  }

  Future<http.Response> deleteComment({required String idComment}) async {
    var body = {'commentId': idComment};
    print('Request: ' + ApiGateway.deleteComment);
    http.Response response =
        await BaseRepository().post(ApiGateway.deleteComment, body);
    print('response StatusCode: ' + response.statusCode.toString());
    return response;
  }

  Future<List<CommentModel>> getAllComment({required String postID}) async {
    print('request URL: ' + ApiGateway.getCommentOfPost + '?postID=$postID');
    http.Response result = await BaseRepository()
        .get(ApiGateway.getCommentOfPost + '?postID=$postID');

    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data'];
      var list = CommentModel.fromJsonList(data);
      print("Data Response: " + data.toString());
      return list;
    }
    return [];
  }
}
