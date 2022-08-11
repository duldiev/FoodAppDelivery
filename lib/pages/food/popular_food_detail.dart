import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/utils/fetch_image.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/bit_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var popularProduct = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(), popularProduct);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height(350),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    FetchImage.get(popularProduct.img!),
                  ),
                )
              ),
            ),
          ),
          // Top icons
          Positioned(
            top: Dimensions.height(45),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'cart-page') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined,),
                        controller.totalItems > 0 ? _counterIcon() : Container(),
                        controller.totalItems > 0 ? _counterValue(controller.totalItems) : Container(),
                      ],
                    ),
                  );
                },),
              ],
            ),
          ),
          // Introduction of food | Expandable text
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.height(350 - 20),
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width(20), right: Dimensions.width(20), top: Dimensions.height(20)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius(20)),
                  topRight: Radius.circular(Dimensions.radius(20)),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: popularProduct.name!,),
                  SizedBox(height: Dimensions.height(20),),
                  const BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height(20),),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: popularProduct.description!),
                    ),
                  ),
                  SizedBox(height: Dimensions.height(20),),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
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
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: const Icon(Icons.remove, color: AppColors.signColor,),
                    ),
                    SizedBox(width: Dimensions.height(10) / 2,),
                    BigText(text: controller.inCartItems.toString()),
                    SizedBox(width: Dimensions.height(10) / 2,),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: const Icon(Icons.add, color: AppColors.signColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.addItem(popularProduct);
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
                  child: BigText(
                    text: "\$${popularProduct.price} | Add to cart",
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

  Positioned _counterIcon() {
    return Positioned(
      right: 2,
      top: 2,
      child: AppIcon(
        icon: Icons.circle,
        size: Dimensions.iconSize(18),
        iconColor: Colors.transparent,
        backgroundColor: AppColors.mainColor,
      ),
    );
  }

  Positioned _counterValue(int totalItems) {
    return Positioned(
      right: totalItems > 9 ? 4 : 8,
      top: 4,
      child: BigText(
        text: totalItems.toString(),
        size: Dimensions.font(12),
        color: Colors.white,
      )
    );
  }
}
