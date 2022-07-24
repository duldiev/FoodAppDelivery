import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  static double space10 = screenHeight / 84.4;
  static double space15 = screenHeight / 56.27;
  static double space20 = screenHeight / 42.2;
  static double space30 = screenHeight / 28.13;
  static double space45 = screenHeight / 18.75;

  static double font12 = screenHeight / 70.33;
  static double font20 = screenHeight / 42.2;

  static double radius20 = screenHeight / 42.2;
  static double radius15 = screenHeight / 56.27;
  static double radius30 = screenHeight / 28.13;
}