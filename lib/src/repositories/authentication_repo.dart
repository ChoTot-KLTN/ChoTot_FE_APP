import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  Future<http.Response> registerAPI(
      {required String name,
      required String email,
      required String phone,
      required String addressDetail,
      required String province,
      required String district,
      required String village,
      required String password}) async {
    Map body = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': {
        'detail': addressDetail,
        'village': village,
        'district': district,
        'province': province
      },
      'password': password
    };

    http.Response response = await http.post(
        Uri.https('chotothd.herokuapp.com', '/auth/register'),
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        });
    return response;
  }

  Future<http.Response> loginAPI(
      {required String email, required String password}) async {
    var body = {'email': email, 'password': password};
    http.Response response =
        await BaseRepository().post(ApiGateway.login, body);
    var jsondata = response.body;
    print(jsondata);
    return response;
  }

  Future<http.Response> verifyAPI({required email, required otp}) async {
    var body = {'email': email, 'otp': otp};
    http.Response response =
        await BaseRepository().post(ApiGateway.verify, body);
    return response;
  }

  Future<http.Response> forgotPasswordAPI({required email}) async {
    var body = {'email': email};
    http.Response response =
        await BaseRepository().post(ApiGateway.forgotPass, body);
    return response;
  }

  Future<http.Response> sendNewPasswordAPI({required email, otp}) async {
    var body = {'email': email, 'otp': otp};
    http.Response response =
        await BaseRepository().post(ApiGateway.sendNewPass, body);
    return response;
  }
}
