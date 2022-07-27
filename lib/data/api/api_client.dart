import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class APIClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseURL;
  late Map<String, String> _mainHeaders;

  APIClient({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
}