import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const root_url = "marketplace-hd.herokuapp.com";
const root_url1 = "https://marketplace-hd.herokuapp.com/";

class BaseRepository {
  // get(String name, [String? params]) async {
  //   Map<String, String> paramsObject = {};
  //   if (params != null)
  //     params.split('&').forEach((element) {
  //       paramsObject[element.split('=')[0].toString()] =
  //           element.split('=')[1].toString();
  //     });
  //   http.Response response = await http.get(
  //     params == null
  //         ? Uri.http(root_url, '/' + name)
  //         : Uri.http(root_url, '/' + name, paramsObject),
  //     headers: getHeader(),
  //   );
  //   return response;
  // }
  get(String name, [String? params]) async {
    Map<String, String> paramsObject = {};
    if (params != null)
      params.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    http.Response response = await http.get(
      params == null
          ? Uri.parse(root_url1 + name)
          : Uri.parse(root_url1 + name),
      headers: getHeader(),
    );
    return response;
  }

  post(String name, Map<String, dynamic> body) async {
    return await http.post(
      Uri.http(root_url, '/' + name),
      headers: getHeader(),
      body: jsonEncode(body),
    );
  }

  put(String name, Map<String, dynamic> body) async {
    return await http.put(
      Uri.http(root_url, '/' + name),
      headers: getHeader(),
      body: jsonEncode(body),
    );
  }

  delete(String name, {Map<String, dynamic>? body}) async {
    return await http.delete(
      Uri.http(root_url, '/' + name),
      headers: getHeader(),
    );
  }

  getHeader() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ' + (GetStorage().read('token') ?? ""),
    };
  }
}
