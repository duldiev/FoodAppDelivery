import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/bit_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _pageItemHeight = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        Container(
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 5,
            itemBuilder: (context, position) { return _buildPageItem(position); },
          ),
        ),
        // dots
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            color: Colors.grey, // Inactive color
            activeColor: AppColors.mainColor,
            size: Size.square(Dimensions.height(8)),
            activeSize: Size.square(Dimensions.height(10)),
          ),
        ),
        // Popular text
        SizedBox(height: Dimensions.height(30),),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width(30)),
          child: Row(
            children: [
              const BigText(text: "Popular"),
              SizedBox(width: Dimensions.width(10),),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width(10),),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: const SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),
        // List of food and images
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => _buildListView(index),
        ),
      ],
    );
  }

  Widget _buildListView(int index) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width(20), right: Dimensions.width(20), bottom: Dimensions.height(10)),
      child: Row(
        children: [
          // Image section
          Container(
            width: Dimensions.height(120),
            height: Dimensions.height(120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius(20)),
              color: Colors.red,
              // image: DecorationImage(
              //   image: AssetImage(
              //     "",
              //   )
              // ),
            ),
          ),
          // Text section
          Expanded(
            child: Container(
              height: Dimensions.height(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius(20)),
                  bottomRight: Radius.circular(Dimensions.radius(20)),
                ),
                color: Colors.red,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: Dimensions.width(10), right: Dimensions.width(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BigText(text: "Nutritious fruit mean in China"),
                    SizedBox(height: Dimensions.height(10),),
                    const SmallText(text: "With chinese characteristics"),
                    SizedBox(height: Dimensions.height(10),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconAndTextWidget(
                          icon: Icons.circle,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text: "1.7km",
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconColor: AppColors.iconColor2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _pageItemHeight * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _pageItemHeight * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _pageItemHeight * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, _pageItemHeight * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.height(10), right: Dimensions.height(10),),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius(30)),
                color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                // image: const DecorationImage(
                //   fit: BoxFit.cover,
                //   image: AssetImage(
                //       ""
                //   ),
                // )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.height(30), right: Dimensions.height(30), bottom: Dimensions.height(30)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius(20)),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height(15),
                  left: Dimensions.height(15),
                  right: Dimensions.height(15),
                ),
                child: const AppColumn(text: "Bitter Orange Marinade",),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
