import 'package:flutter/material.dart';
import 'package:theblue_crown/utils/dimensions.dart';

// import '../../../core/utils/ui_helper.dart';
// import 'package:foodie/core/utils/ui_helper.dart';

class ProductInfoText extends StatelessWidget {
  const ProductInfoText({
    Key? key,
    required this.text,
    required this.value,
    this.alignment = Alignment.topRight,
  })
      : super(key: key);

  final String text;
  final String value;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            text,
            style:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 21),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.blue,
              fontSize: 20,
              height: Dimensions.height10 / 5,
            ),
          ),
          SizedBox(height: Dimensions.height45 / 2),
        ],
      ),
    );
  }
}