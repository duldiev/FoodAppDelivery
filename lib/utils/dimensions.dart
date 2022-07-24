import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  static double size10 = screenHeight / 84.4;
  static double size15 = screenHeight / 56.27;
  static double size24 = screenHeight / 35.17;
  static double size20 = screenHeight / 42.2;
  static double size30 = screenHeight / 28.13;
  static double size45 = screenHeight / 18.75;

  static double font12 = screenHeight / 70.33;
  static double font20 = screenHeight / 42.2;

  static double radius20 = screenHeight / 42.2;
  static double radius15 = screenHeight / 56.27;
  static double radius30 = screenHeight / 28.13;
}