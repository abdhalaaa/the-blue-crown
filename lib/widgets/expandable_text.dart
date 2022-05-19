import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/custom_small_text.dart';

class ExpandableText extends StatefulWidget {

  final String text;

  const ExpandableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {

  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ?
      CustomSmallText(text: firstHalf, size: Dimensions.font16) :
      Column(
        children: [
          CustomSmallText(
            text: hiddenText ?
            (firstHalf + "...") :
            (firstHalf + secondHalf),

            size: Dimensions.font16,
            height: 1.8,
          ),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
              child: Row(
                children: [
                  hiddenText ?
                  CustomSmallText(
                    text: "Read More".tr,
                    color: Colors.blue,
                  ) :
                  CustomSmallText(
                    text: "Read Lese".tr,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 5,),
                  Icon(
                  hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: Colors.blue,
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}



