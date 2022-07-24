import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/food_page_body.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/bit_text.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height(45), bottom: Dimensions.height(45)),
              padding: EdgeInsets.only(left: Dimensions.width(20), right: Dimensions.width(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const BigText(text: "Country", color: AppColors.mainColor,),
                      Row(
                        children: [
                          const SmallText(text: "City", color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded, size: Dimensions.height(24),),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width(45),
                      height: Dimensions.height(45),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius(15)),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: Dimensions.height(24),),
                    ),
                  )
                ],
              ),
            ),
          ),
          const FoodPageBody(),
        ],
      ),
    );
  }
}
