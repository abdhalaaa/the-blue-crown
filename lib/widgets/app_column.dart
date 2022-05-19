import 'package:flutter/material.dart';
import 'package:theblue_crown/utils/dimensions.dart';

import 'custom_big_text.dart';
import 'custom_small_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {

  final String text;
  final Color color;

  const AppColumn({
    Key? key,
    required this.text, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBigText(
          text: text,
          size: Dimensions.font26,
          color: color,
        ),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index)
              {return  const Icon(
                Icons.star,
                color: Colors.blue,
                size: 15,
              );
              },
              ),
            ),
            SizedBox(width: Dimensions.width10,),
            const CustomSmallText(text: "4.5",),
            SizedBox(width: Dimensions.width10,),
            const CustomSmallText(text: "1287",),
            SizedBox(width: Dimensions.width10,),
            const CustomSmallText(text: "comments",),
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: Colors.blue,
            ),
            const IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7Km",
              iconColor: Colors.red,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: Colors.purple.shade300,
            ),
          ],
        ),
      ],
    );
  }
}
