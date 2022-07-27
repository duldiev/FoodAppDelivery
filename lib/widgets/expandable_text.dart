import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      hiddenText = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ? SmallText(text: firstHalf, size: Dimensions.font(16),) : _showExpandableTextWithButton(),
    );
  }

  Widget _showExpandableTextWithButton() {
    return Column(
      children: [
        SmallText(
          text: hiddenText ? ("$firstHalf...") : (firstHalf + secondHalf),
          size: Dimensions.font(14),
          height: 1.8,
          color: AppColors.paraColor,
        ),
        SizedBox(height: Dimensions.height(10),),
        InkWell(
          onTap: () {
            setState(() {
              hiddenText = !hiddenText;

            });
          },
          child: Row(
            children: [
              SmallText(
                text: hiddenText ? "Show more" : "Show less",
                color: AppColors.mainColor,
                size: Dimensions.font(12),
              ),
              Icon(
                hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                color: AppColors.mainColor,
                size: Dimensions.font(14),
              ),
            ],
          ),
        )
      ],
    );
  }
}

