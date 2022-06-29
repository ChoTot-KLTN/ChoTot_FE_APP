import 'dart:convert';

import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/address_model.dart';
import 'package:chotot_app/src/models/user_model.dart';
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
        Uri.https('marketplace111.herokuapp.com', '/auth/register'),
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

  Future<UserModel?> getAuthAPI() async {
    http.Response response = await BaseRepository().get(ApiGateway.getAuth);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      print("dataUser: " + jsonResponse.toString());
      return UserModel.fromMap(jsonResponse['user']);
    }
  }

  Future<http.Response> changePasswordAPI(
      {required String oldPassword, required String newPassword}) async {
    print('request URL: ' +
        ApiGateway.changePassword +
        'oldPassword: $oldPassword, newPassword: $newPassword');
    var body = {'oldPassword': oldPassword, 'newPassword': newPassword};
    http.Response response =
        await BaseRepository().post(ApiGateway.changePassword, body);
    return response;
  }

  Future<http.Response> updateInfoAPI(
      {required String name,
      required String phone,
      required AddressModel address,
      required String avatar}) async {
    print('request URL: ' +
        ApiGateway.updateInfor +
        'name: $name, phone: $phone');
    var addressBody = {
      "detail": address.detail,
      "village": address.village,
      "district": address.district,
      "province": address.province
    };
    var body = {
      'name': name,
      'phone': phone,
      'address': addressBody,
      'avatar': avatar
    };
    http.Response response =
        await BaseRepository().post(ApiGateway.updateInfor, body);
    return response;
  }

  Future<http.Response> loginPhoneAPI({required String phone}) async {
    print("URL request: " + ApiGateway.loginWithPhone + "Phone=$phone");
    var body = {'phone': phone};
    http.Response response =
        await BaseRepository().post(ApiGateway.loginWithPhone, body);
    // var jsondata = response.body;
    print("status reponse: " + response.statusCode.toString());
    return response;
  }

  Future<http.Response> loginPhoneOTP(
      {required String phone, required String otp}) async {
    print("URL request: " + ApiGateway.loginPhoneOTP + "Phone=$phone");
    var body = {'phone': phone, 'otp': otp};
    http.Response response =
        await BaseRepository().post(ApiGateway.loginPhoneOTP, body);
    // var jsondata = response.body;
    print("status reponse: " + response.statusCode.toString());
    return response;
  }
}
