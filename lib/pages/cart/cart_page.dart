import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/utils/fetch_image.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bit_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height(60),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize(24),
                ),
                SizedBox(width: Dimensions.width(100),),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize(24),
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize(24),
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height(110),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            bottom: 0,
            child: Container(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (controller) {
                  List<CartModel> cartList = controller.getItems;
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (_, index) {
                      return _buildListItem(index, controller, cartList);
                    },
                  );
                },),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Container(
          height: Dimensions.height(120),
          padding: EdgeInsets.only(
            top: Dimensions.height(30),
            bottom: Dimensions.height(30),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
          ),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius(30)),
              topLeft: Radius.circular(Dimensions.radius(30)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height(10),
                  bottom: Dimensions.height(10),
                  left: Dimensions.width(10),
                  right: Dimensions.width(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius(20)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width(20) / 2,),
                    BigText(text: "\$${controller.totalAmount.toString()}"),
                    SizedBox(width: Dimensions.width(20) / 2,),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height(10),
                    bottom: Dimensions.height(10),
                    left: Dimensions.width(10),
                    right: Dimensions.width(10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius(20)),
                  ),
                  child: const BigText(
                    text: "Check out", // ${popularProduct.price}
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },),
    );
  }

  Widget _buildListItem(int index, CartController controller, List<CartModel> cartList) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height(15)),
      height: 100,
      width: double.maxFinite,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              var popularProductIndex = Get.find<PopularProductController>()
                  .popularProductList
                  .indexOf(cartList[index].product!);
              if (popularProductIndex >= 0) {
                Get.toNamed(RouteHelper.getPopularFood(popularProductIndex, 'cart-page'));
              } else {
                var recommendedProductIndex = Get.find<RecommendedProductController>()
                    .recommendedProductList
                    .indexOf(cartList[index].product!);
                Get.toNamed(RouteHelper.getRecommendedFood(recommendedProductIndex, 'cart-page'));
              }
            },
            child: Container(
              height: Dimensions.height(100),
              width: Dimensions.height(100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius(20)),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      FetchImage.get(controller.getItems[index].img!),
                    ),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
          SizedBox(width: Dimensions.width(10),),
          Expanded(
            child: Container(
              height: Dimensions.height(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(
                    text: controller.getItems[index].name!,
                  ),
                  const SmallText(
                    text: "Spicy",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "\$${controller.getItems[index].price}",
                        color: Colors.redAccent,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height(10),
                          bottom: Dimensions.height(10),
                          left: Dimensions.width(10),
                          right: Dimensions.width(10),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius(20)),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.addItem(cartList[index].product!, -1);
                              },
                              child: const Icon(Icons.remove, color: AppColors.signColor,),
                            ),
                            SizedBox(width: Dimensions.height(10) / 2,),
                            BigText(text: cartList[index].quantity.toString()),//popularProductController.inCartItems.toString()),
                            SizedBox(width: Dimensions.height(10) / 2,),
                            GestureDetector(
                              onTap: () {
                                controller.addItem(cartList[index].product!, 1);
                              },
                              child: const Icon(Icons.add, color: AppColors.signColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
