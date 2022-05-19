import 'package:flutter/material.dart';
import 'custom_small_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function onPressed;

  const CustomButton(
      {
        Key? key,
        this.text = '',
        required this.onPressed,
        this.textColor = Colors.white,

      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
              ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          padding: MaterialStateProperty.all(const EdgeInsets.all(18)),
          ),
      onPressed: () {
        onPressed.call();
      },
      child: CustomSmallText(
          text: text,
           color: textColor,
      ),
    );

  }
}
