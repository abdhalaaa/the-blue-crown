import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/models/cart_model.dart';
import 'package:theblue_crown/pages/home/home_view.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/utils/app_constants.dart';
import 'package:theblue_crown/widgets/app_icon.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import 'package:theblue_crown/widgets/custom_small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=> ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=>1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }

      return CustomBigText(
        text: outputDate,
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: Dimensions.height10 * 10,
              color: Colors.blueAccent,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height45,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomBigText(
                    height: 2.5,
                    text: "Cart History".tr,
                    color: Colors.white,
                  ),
                  const AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.blue,
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                ],
              ),
            ),
            //body
            GetBuilder<CartController>(builder: (_cartController){
              var cartLength = _cartController.getCartHistoryList();
              return cartLength.length > 0 ?
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i=0; i<itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height30 * 4,
                            margin: EdgeInsets.only(
                                bottom: Dimensions.height20
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter < getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index <= 2 ? Container(
                                          height: Dimensions.height20 * 4,
                                          width: Dimensions.height20 * 4,
                                          margin: EdgeInsets.only(
                                            right: Dimensions.width10 / 2,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                            child: CachedNetworkImage(
                                              imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCartHistoryList[ listCounter - 1 ].img!,
                                              height: Dimensions.listViewImgSize,
                                              width:Dimensions.listViewImgSize,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Container(color: Colors.black12,),
                                              errorWidget: (context, url, error) => Container(
                                                color: Colors.black12,
                                                child: const Icon(Icons.error, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                          //   image: DecorationImage(
                                          //     fit: BoxFit.cover,
                                          //     image: NetworkImage(
                                          //         AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCartHistoryList[ listCounter - 1 ].img!
                                          //     ),
                                          //   ),
                                          // ),
                                        ) : Container();
                                      }
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20 * 4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          CustomSmallText(
                                            text: "Total".tr,
                                          ),
                                          CustomBigText(
                                            text: itemsPerOrder[i].toString() + " Items".tr,
                                            color: Colors.blue,
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder = {};
                                              for(int j=0; j<getCartHistoryList.length; j++){
                                                if(getCartHistoryList[j].time == orderTime[i]){
                                                  moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical: Dimensions.height10 / 2,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              child: CustomSmallText(
                                                text: "one more".tr,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          ),
                      ],
                    ),
                  ),
                ),
              ) :
                  SizedBox(
                    //color: Colors.blueAccent,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Column(
                      children: [
                        Lottie.asset('assets/order-history.json',),
                        const SizedBox(height: 15,),
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const HomeView(), transition: Transition.fade),
                            text: 'Order Now'.tr,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
            })
          ],
        ),
      ),
    );
  }
}
