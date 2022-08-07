import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/models/products.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cartController;

  PopularProductController({required this.popularProductRepo});

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoad = true;
      update();
    } else {

    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement)
      print("Increment ${_quantity}");
    else
      print("Decrement ${_quantity}");
    _quantity = _quantity + (isIncrement ? ((_inCartItems + _quantity) + 1 <= 20 ? 1 : _zeroWithSnackbar("add")) : ((_inCartItems + _quantity) - 1 >= 0 ? -1 : _zeroWithSnackbar("reduce")));
    update();
  }

  int _zeroWithSnackbar(String text) {
    Get.snackbar(
      "Item count", "You can't $text more!",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
    );
    if (text == "add") return 0;
    if (_inCartItems > 0) {
      return _quantity = -_inCartItems;
    }
    return 0;
  }

  void initProduct(CartController cartController, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    if (_cartController.isExist(product)) {
      _inCartItems = _cartController.getQuantity(product);
    }
    print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cartController.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);

    _cartController.items.forEach((key, value) {
      print("The id is " + value.id.toString() + ". The quantity is " + value.quantity.toString());
    });

    update();
  }

  int get totalItems{
    return _cartController.totalItems;
  }
}