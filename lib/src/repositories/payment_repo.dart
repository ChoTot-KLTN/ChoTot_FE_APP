import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {
  // thanh toán này là bằng VNpay
  Future<http.Response> preorityPostAPI(
      {required String idPost,
      required int prices,
      required nameOfPoster}) async {
    print('request URL: ' +
        ApiGateway.paymentVNPay +
        '/postId=$idPost&prices=$prices&nameOfPoster=$nameOfPoster');
    var bodypost = {
      "idPost": idPost,
      "prices": prices,
      "nameOfPoster": nameOfPoster
    };
    http.Response result =
        await BaseRepository().post(ApiGateway.paymentVNPay, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }

  // Thanh toán này là bằng paypal
  Future<http.Response> paymentPostAPI(
      {required String idPost, required int price}) async {
    print('request URL: ' +
        ApiGateway.paymentPaypal +
        '/postId=$idPost&price=$price');
    var bodypost = {"idPost": idPost, "price": price};
    http.Response result =
        await BaseRepository().post(ApiGateway.paymentPaypal, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }

  Future<http.Response> vnpayRevenueAPI(
      {required String idPost, required int price}) async {
    print('request URL: ' +
        ApiGateway.vnPayRevenue +
        '?postId=$idPost&price=$price');
    var bodypost = {"idPost": idPost, "price": price};
    http.Response result =
        await BaseRepository().post(ApiGateway.vnPayRevenue, bodypost);
    print("statusCode: " + result.statusCode.toString());
    return result;
  }
}
