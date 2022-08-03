import 'package:food_delivery_app/utils/app_constants.dart';

class FetchImage {
  static String get(String url) {
    return AppConstants.BASE_URL + AppConstants.UPLOAD_URL + url;
  }
}