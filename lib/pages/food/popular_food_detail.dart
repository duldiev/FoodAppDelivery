import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';

import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/bit_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height(350),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/food4.jpg",
                  ),
                )
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height(45),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
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
                  const AppColumn(text: "Bitter Orange Marinade",),
                  SizedBox(height: Dimensions.height(20),),
                  const BigText(text: "Introduce"),

                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height(120),
        padding: EdgeInsets.only(
          top: Dimensions.height(30),
          bottom: Dimensions.height(30),
          left: Dimensions.width(20),
          right: Dimensions.width(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
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
                  const Icon(Icons.remove, color: AppColors.signColor,),
                  SizedBox(width: Dimensions.height(10) / 2,),
                  const BigText(text: "0"),
                  SizedBox(width: Dimensions.height(10) / 2,),
                  const Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
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
                text: "\$10 | Add to cart",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
