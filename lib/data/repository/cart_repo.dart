import 'dart:convert';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> _cartList = [];
  List<String> _cartHistoryList = [];

  void addToCartList(List<CartModel> cartModelList) {
    // to reset the storage
    // sharedPreferences.remove(AppConstants.CART_LIST_KEY);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST_KEY);

    _cartList = [];
    var time = DateTime.now().toString();

    cartModelList.forEach((element) {
      element.time = time;
      return _cartList.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST_KEY, _cartList);
  }

  List<CartModel> getCartList() {
    List<String> cartList = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST_KEY)) {
      cartList = sharedPreferences.getStringList(AppConstants.CART_LIST_KEY)!;
    }

    List<CartModel> cartModelList = [];
    cartList.forEach((element) => cartModelList.add(CartModel.fromJson(jsonDecode(element))));
    return cartModelList;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST_KEY)) {
      _cartHistoryList = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST_KEY)!;
    }

    for (int i = 0; i < _cartList.length; i++) {
      _cartHistoryList.add(_cartList[i]);
    }

    removeCard();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST_KEY, _cartHistoryList);
    // print("The length of history list is ${getCartHistoryList().length}");
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST_KEY)) {
      _cartHistoryList = [];
      _cartHistoryList = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST_KEY)!;
    }

    List<CartModel> cartModelHistoryList = [];
    _cartHistoryList.forEach((element) => cartModelHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartModelHistoryList;
  }
  
  void removeCard() {
    _cartList = [];
    sharedPreferences.remove(AppConstants.CART_LIST_KEY);
  }
}