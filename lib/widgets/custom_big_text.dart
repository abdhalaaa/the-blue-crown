import 'package:flutter/material.dart';
import 'package:theblue_crown/utils/dimensions.dart';

class CustomBigText extends StatelessWidget {
  final String text;
  final Color color;
  // final Alignment alignment;
  final double height;
  final double size;
  TextOverflow overflow;

  CustomBigText({
    Key? key,
    this.text = '',
    this.color = Colors.black,
    // this.alignment = Alignment.topRight,
    this.height = 1,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        height: height,
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
