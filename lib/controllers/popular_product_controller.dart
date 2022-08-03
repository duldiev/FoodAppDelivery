import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/models/products.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  int _quantity = 0;
  String get quantity => _quantity.toString();

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
    _quantity = _quantity + (isIncrement ? (_quantity < 20 ? 1 : 0) : (_quantity - 1 >= 0 ? -1 : 0));
    update();
  }
}