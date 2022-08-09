import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/utils/fetch_image.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bit_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';

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
                  var _cartList = controller.getItems;
                  return ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_, index) {
                      return _buildListItem(index, controller, _cartList);
                    },
                  );
                },),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(int index, CartController controller, var cartList) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height(15)),
      height: 100,
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
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
                  SmallText(
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
