import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/utils/fetch_image.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/bit_text.dart';
import 'package:food_delivery_app/models/products.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  final String longText = """Sense child do state to defer mr of forty. Become latter but nor abroad wisdom waited. Was delivered gentleman acuteness but daughters. In as of whole as match asked. Pleasure exertion put add entrance distance drawings. In equally matters showing greatly it as. Want name any wise are able park when. Saw vicinity judgment remember finished men throwing. For norland produce age wishing. To figure on it spring season up. Her provision acuteness had excellent two why intention. As called mr needed praise at. Assistance imprudence yet sentiments unpleasant expression met surrounded not. Be at talked ye though secure nearer. She suspicion dejection saw instantly. Well deny may real one told yet saw hard dear. Bed chief house rapid right the. Set noisy one state tears which. No girl oh part must fact high my he. Simplicity in excellence melancholy as remarkably discovered. Own partiality motionless was old excellence she inquietude contrasted. Sister giving so wicket cousin of an he rather marked. Of on game part body rich. Adapted mr savings venture it or comfort affixed friends. Carried nothing on am warrant towards. Polite in of in oh needed itself silent course. Assistance travelling so especially do prosperous appearance mr no celebrated. Wanted easily in my called formed suffer. Songs hoped sense as taken ye mirth at. Believe fat how six drawing pursuit minutes far. Same do seen head am part it dear open to. Whatever may scarcely judgment had. Arrival entered an if drawing request. How daughters not promotion few knowledge contented. Yet winter law behind number stairs garret excuse. Minuter we natural conduct gravity if pointed oh no. Am immediate unwilling of attempted admitting disposing it. Handsome opinions on am at it ladyship. No in he real went find mr. Wandered or strictly raillery stanhill as. Jennings appetite disposed me an at subjects an. To no indulgence diminution so discovered mr apartments. Are off under folly death wrote cause her way spite. Plan upon yet way get cold spot its week. Almost do am or limits hearts. Resolve parties but why she shewing. She sang know now how nay cold real case.""";

  @override
  Widget build(BuildContext context) {
    Products popularProduct = Get.find<PopularProductController>().popularProductList[pageId];
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
                    Get.back();
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: const AppIcon(icon: Icons.shopping_cart_outlined),),
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
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProductController) {
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
                        popularProductController.setQuantity(false);
                      },
                      child: const Icon(Icons.remove, color: AppColors.signColor,),
                    ),
                    SizedBox(width: Dimensions.height(10) / 2,),
                    BigText(text: popularProductController.quantity),
                    SizedBox(width: Dimensions.height(10) / 2,),
                    GestureDetector(
                      onTap: () {
                        popularProductController.setQuantity(true);
                      },
                      child: const Icon(Icons.add, color: AppColors.signColor),
                    ),
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
                child: BigText(
                  text: "\$${popularProduct.price} | Add to cart",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },),
    );
  }
}
