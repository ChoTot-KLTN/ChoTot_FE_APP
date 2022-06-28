import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class ReportRepository {
  Future<http.Response> reportPostAPI(
      {required String idPost,
      required String idReporter,
      required String nameReporter,
      required String avatar,
      required String reason}) async {
    print('request URL: ' +
        ApiGateway.reportPost +
        '/postId=$idPost&idReporter=$idReporter&reason=$reason');
    var bodypost = {
      "idPost": idPost,
      "idReporter": idReporter,
      "reason": reason,
      "nameReporter": nameReporter,
      "avatar": avatar,
    };
    http.Response result =
        await BaseRepository().post(ApiGateway.reportPost, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }
}
