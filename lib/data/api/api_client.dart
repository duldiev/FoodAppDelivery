import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class APIClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseURL;
  late Map<String, String> _mainHeaders;

  APIClient({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}