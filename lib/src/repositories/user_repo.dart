import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/owner_post_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<http.Response> createRating(
      {required String idOwner, required int rate}) async {
    print('request URL: ' + ApiGateway.createRating);
    var bodypost = {"idOwner": idOwner, "rate": rate};
    http.Response result =
        await BaseRepository().post(ApiGateway.createRating, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }

  Future<OwnerPostModel?> getAuthAPI({required String userId}) async {
    print("request URL: " + ApiGateway.getUserInfor + "?userId=$userId");
    http.Response response =
        await BaseRepository().get(ApiGateway.getUserInfor + "?userId=$userId");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      print("dataUser: " + jsonResponse.toString());
      return OwnerPostModel.fromMap(jsonResponse['user']);
    }
  }
}
