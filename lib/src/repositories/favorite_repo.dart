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

  Future<List<FavoritePostModel>?> getAllPostRegister() async {}
}
