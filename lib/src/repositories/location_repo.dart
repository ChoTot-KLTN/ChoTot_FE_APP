import 'package:chotot_app/src/models/district_model.dart';
import 'package:chotot_app/src/models/province.dart';

import 'package:chotot_app/src/models/village_model.dart';
import 'package:dio/dio.dart';

const String baseURL = 'location-vn.herokuapp.com';

class LocationRepository {
  Map<String, String> subHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Connection': 'keep-alive',
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
  };

  // Future<List<ProvinceModel>> getDataProvince() async {
  //   http.Response response =
  //       await http.get(Uri.https(baseURL, "/api/province"), headers: subHeader);

  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     return ProvinceModel.fromJsonList(jsonResponse);
  //   }

  //   return [];
  // }

  Future<List<Province>> getDataProvince() async {
    var response = await Dio().get(
      "https://location-vn.herokuapp.com/api/province",
    );

    final data = response.data;
    if (data != null) {
      return Province.fromJsonList(data);
    }
    return [];
  }

  Future<List<DistrictModel>> getDataDicstrict(String id) async {
    var response = await Dio().get(
      "https://location-vn.herokuapp.com/api/province/$id/district",
    );

    final data = response.data;
    if (data != null) {
      return DistrictModel.fromJsonList(data);
    }
    return [];
  }

  Future<List<Village>> getDataVillage(String id) async {
    var response = await Dio()
        .get("https://location-vn.herokuapp.com/api/district/$id/village");
    final data = response.data;
    if (data != null) {
      return Village.fromJsonList(data);
    }
    return [];
  }
}
