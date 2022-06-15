import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/owner_post_model.dart';
import 'package:chotot_app/src/models/rating_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<http.Response> createRating(
      {required String idOwner, required double rate}) async {
    print('request URL: ' + ApiGateway.createRating);
    var bodypost = {"idOwner": idOwner, "rate": rate};
    http.Response result =
        await BaseRepository().post(ApiGateway.createRating, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }

  Future<OwnerPostModel?> getUserInforAPI({required String userId}) async {
    print("request URL: " + ApiGateway.getUserInfor + "?userId=$userId");
    http.Response response =
        await BaseRepository().get(ApiGateway.getUserInfor + "?userId=$userId");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      print("dataUser: " + jsonResponse.toString());
      return OwnerPostModel.fromMap(jsonResponse);
    }
    print("status: " + response.statusCode.toString());
    return null;
  }

  Future<RatingModel?> getUserRating({required String idOwner}) async {
    print("request URL: " + ApiGateway.getRating + "?idOwner=$idOwner");
    http.Response response =
        await BaseRepository().get(ApiGateway.getRating + "?idOwner=$idOwner");
    print("status" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      print("dataRating: " + jsonResponse.toString());
      return RatingModel.fromMap(jsonResponse);
    }
    var jsonResponse1 = jsonDecode(response.body)['data'];
    return RatingModel.fromMap(jsonResponse1);
  }
}
