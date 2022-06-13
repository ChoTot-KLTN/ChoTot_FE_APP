import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class SearchPostRepository {
  Future<List<PostModel>> searchPostTech({
    int? maxPrice,
    int? minPrice,
    String? category,
    String? province,
    String? brand,
    int? page,
    int? limit,
  }) async {
    String provinceResult = "";
    if (province != null) {
      provinceResult = province;
    }
    print('request URL: ' +
        ApiGateway.searchPostTech +
        '?maxPrice=$maxPrice&minPrice=$minPrice&category=$category&province=$provinceResult&brand=$brand&page=$page&limit=$limit');

    http.Response result = await BaseRepository().get(ApiGateway
            .searchPostTech +
        '?maxPrice=$maxPrice&minPrice=$minPrice&category=$category&province=$provinceResult&brand=$brand&page=$page&limit=$limit');

    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data'];
      var list = PostModel.fromJsonList(data);
      print("Data Response: " + data.toString());
      return list;
    }
    return [];
  }

  Future<List<PostModel>> searchPostBDS({
    int? maxPrice,
    int? minPrice,
    String? category,
    String? province,
    int? area,
    int? maxArea,
    int? minArea,
    int? page,
    int? limit,
  }) async {
    String provinceResult = "";
    if (province != null) {
      provinceResult = province;
    }
    String areaResult = "";
    if (area != null) {
      areaResult = area.toString();
    }
    print('request URL: ' +
        ApiGateway.searchPostBDS +
        '?maxPrice=$maxPrice&minPrice=$minPrice&category=$category&province=$provinceResult&area=$areaResult&maxArea=$maxArea&minArea=$minArea&page=$page&limit=$limit');
    http.Response result = await BaseRepository().get(ApiGateway.searchPostBDS +
        '?maxPrice=$maxPrice&minPrice=$minPrice&category=$category&province=$provinceResult&area=$areaResult&maxArea=$maxArea&minArea=$minArea&page=$page&limit=$limit');

    if (result.statusCode == 200) {
      var data = jsonDecode(result.body)['data'];
      var list = PostModel.fromJsonList(data);
      print("Data Response: " + data.toString());
      return list;
    }
    return [];
  }
}
