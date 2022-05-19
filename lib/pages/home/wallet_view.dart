import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:theblue_crown/pages/cart/cart_history.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import '../../routes/route_helper.dart';
import '../../widgets/custom_small_text.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomBigText(
            text: "Wallet".tr,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: Dimensions.height15, right: Dimensions.width15, left: Dimensions.width15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomBigText(
                    text: "0.00",
                    size: 40,
                    // alignment: Alignment.centerRight,
                  ),
                  SizedBox(width: Dimensions.width15,),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    child: CustomBigText(
                      text: "E.p".tr,
                    ),
                  ),
                ],
              ),
              CustomSmallText(
                text: "Available balance in the wallet".tr,
                size: 15,
              ),
              SizedBox(height: Dimensions.height45 ),
              Padding(
                padding: EdgeInsets.only(right: Dimensions.width20),
                child: RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const CartHistory(), transition: Transition.fade),
                    text: "Previous Transactions".tr,
                    style: TextStyle( color: Colors.black, fontSize: Dimensions.font20,),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height45 ),
              CustomBigText(text: "Payment methods".tr,),
              Padding(
                padding: EdgeInsets.only(top: Dimensions.height15, right: Dimensions.width30),
                child: CustomBigText(text: "  Payment when receiving".tr,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
