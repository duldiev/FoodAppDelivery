import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/utils/fetch_image.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bit_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../models/products.dart';
import '../../routes/route_helper.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel recommendedProduct = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(), recommendedProduct);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                  child: AppIcon(icon: Icons.clear, size: Dimensions.iconSize(30),),
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
                        AppIcon(icon: Icons.shopping_cart_outlined, size: Dimensions.iconSize(30),),
                        controller.totalItems > 0 ? _counterIcon() : Container(),
                        controller.totalItems > 0 ? _counterValue(controller.totalItems) : Container(),
                      ],
                    ),
                  );
                },),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimensions.height(10), bottom: Dimensions.height(10),),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius(20)),
                    topLeft: Radius.circular(Dimensions.radius(20)),
                  ),
                ),
                child: Center(child: BigText(text: recommendedProduct.name!, size: Dimensions.font(26)),),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                FetchImage.get(recommendedProduct.img!),
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width(20), right: Dimensions.width(20),),
                  child: ExpandableText(text: recommendedProduct.description!,),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width(50),
                right: Dimensions.width(50),
                top: Dimensions.height(10),
                bottom: Dimensions.height(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize(20),
                    ),
                  ),
                  BigText(
                    text: "\$${recommendedProduct.price} x ${controller.inCartItems}",
                    size: Dimensions.font(22),
                    color: AppColors.mainBlackColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize(20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(recommendedProduct);
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
                        text: "\$${recommendedProduct.price} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }

  Positioned _counterIcon() {
    return Positioned(
      right: 0,
      top: 0,
      child: AppIcon(
        icon: Icons.circle,
        size: Dimensions.iconSize(16),
        iconColor: Colors.transparent,
        backgroundColor: AppColors.mainColor,
      ),
    );
  }

  Positioned _counterValue(int totalItems) {
    return Positioned(
        right: totalItems > 9 ? 2 : 4,
        top: 3,
        child: BigText(
          text: totalItems.toString(),
          size: Dimensions.font(10),
          color: Colors.white,
        )
    );
  }
}
