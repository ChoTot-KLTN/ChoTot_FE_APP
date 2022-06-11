import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/favorite_post_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class FavoriteRepository {
  Future<http.Response> registerFavorite({required String idPost}) async {
    var body = {'idPost': idPost};
    print('Request: ' + ApiGateway.registerFavorite);
    http.Response response =
        await BaseRepository().post(ApiGateway.registerFavorite, body);
    print('response StatusCode: ' + response.statusCode.toString());
    return response;
  }

  Future<List<FavoritePostModel>?> getAllPostRegister() async {
    print('request URL: ' + ApiGateway.getAllPostFavorite);
    http.Response result =
        await BaseRepository().get(ApiGateway.getAllPostFavorite);

    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data'];
      var list = FavoritePostModel.fromJsonList(data);
      print("Data Response: " + data.toString());
      return list;
    }
    return [];
  }

  Future<http.Response> cancelFavorite({required String idFavorite}) async {
    var body = {'isActive': false, 'idFavorite': idFavorite};
    print('Request: ' + ApiGateway.cancelFavorite);
    http.Response response =
        await BaseRepository().put(ApiGateway.cancelFavorite, body);
    print('response StatusCode: ' + response.statusCode.toString());
    return response;
  }
}
