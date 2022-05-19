import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:theblue_crown/base/no_data_page.dart';
import 'package:theblue_crown/controllers/auth_controller.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/controllers/location_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/recommended_product_controller.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/utils/app_constants.dart';
import 'package:theblue_crown/widgets/app_icon.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import 'package:theblue_crown/widgets/custom_small_text.dart';

import '../../widgets/app_column.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radius20 * 1.3),
        topRight: Radius.circular(Dimensions.radius20 * 1.3),
      ),
      child: WillPopScope(
        onWillPop: () async {
          Get.toNamed(RouteHelper.getInitial());
          return true;
        },
        child: Scaffold(
              backgroundColor: Colors.grey[300],
          //backgroundColor: Colors.blue,
              body: Stack(
                  children: [
                    //header
                    Positioned(
                      top: Dimensions.height20 * 1.2,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppIcon(
                            icon: Icons.arrow_back_ios_outlined,
                            iconColor: Colors.grey.shade600,
                            backgroundColor: Colors.white,
                            iconsize: Dimensions.iconSize24,
                          ),
                          SizedBox(width: Dimensions.width20 * 5,),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getInitial());
                            },
                            child: Container(
                              height: Dimensions.height45,
                              width: Dimensions.width20 * 2 + 5,
                              // child: Lottie.asset('assets/home.json'),
                              child: Icon(
                                  Icons.home_outlined,
                                size: Dimensions.iconSize24 * 1.5,
                                color: Colors.grey.shade600,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.grey.shade200,
                                boxShadow: [
                                  //darker shadow at bottom right
                                  BoxShadow(
                                    color: Colors.grey.shade700.withOpacity(0.7),
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    spreadRadius: 0.1
                                  ),

                                  //Lighter shadow at top right
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(-4, -4),
                                      blurRadius: 15,
                                      spreadRadius: 1
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.grey.shade200,
                                    Colors.grey.shade400
                                  ],
                                  stops: [
                                    0.1,
                                    0.9
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.grey.shade200,
                              boxShadow: [
                                //darker shadow at bottom right
                                BoxShadow(
                                    color: Colors.grey.shade700.withOpacity(0.7),
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    spreadRadius: 0.1
                                ),

                                //Lighter shadow at top right
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: Offset(-4, -4),
                                    blurRadius: 15,
                                    spreadRadius: 1
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.grey.shade200,
                                  Colors.grey.shade400
                                ],
                                stops: [
                                  0.1,
                                  0.9
                                ],
                              ),
                            ),
                            height: Dimensions.height45,
                            width: Dimensions.width20 * 2 + 5,
                            // child: Lottie.asset('assets/cart.json'),
                            child: Icon(Icons.shopping_cart_outlined, color: Colors.grey.shade600,),
                          ),
                        ],
                      ),
                    ),
                    //body
                    GetBuilder<CartController>(builder: (_cartController){
                    return _cartController.getItems.length > 0
                        ?
                    Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height15
                        ),
                        //color: Colors.redAccent,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (cartController){
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index){
                                    return SizedBox(
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              var popularIndex = Get.find<PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index].product!);
                                              if(popularIndex >= 0){
                                                Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                              }else{
                                                var recommendedIndex = Get.find<RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index].product!);
                                                if(recommendedIndex < 0){
                                                  Get.snackbar(
                                                    "History product", "Product review is not available for history products",
                                                    backgroundColor: Colors.grey.shade200,
                                                    colorText: Colors.red,
                                                  );
                                                }else{
                                                  Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions.height10
                                              ),
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                child: CachedNetworkImage(
                                                  imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!,
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
                                              //     image: DecorationImage(
                                              //       fit: BoxFit.cover,
                                              //       image: NetworkImage(
                                              //           AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!
                                              //       ),
                                              //     ),
                                              //     borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              //     color: Colors.white
                                              // ),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10,),
                                          Expanded(
                                            child: SizedBox(
                                              height: Dimensions.height20 * 5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  CustomBigText(
                                                    text: cartController.getItems[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(width: Dimensions.width30,),
                                                  CustomSmallText(
                                                    text: "مادة فعالة انيونية",
                                                    color: Colors.black54,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CustomBigText(
                                                        text: cartController.getItems[index].price.toString(),
                                                        color: Colors.redAccent,
                                                      ),
                                                      SizedBox(width: Dimensions.width30 * 1.5),
                                                      GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(_cartList[index].product!, -1000);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.delete_outline,
                                                              color: Colors.blue[700],
                                                            ),
                                                            SizedBox(width: Dimensions.width10 / 10,),
                                                            CustomSmallText(text: "remove".tr, color: Colors.blue[700]!, size: Dimensions.font16,)
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: Dimensions.width10 / 3,),
                                                      Container(
                                                        padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10,),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                          color: Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){
                                                                cartController.addItem(_cartList[index].product!, -1);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Colors.grey.shade800,
                                                              ),
                                                            ),
                                                            SizedBox(width: Dimensions.width10 / 2,),
                                                            CustomBigText(
                                                              text: _cartList[index].quantity.toString(),//popularProduct.inCartItems.toString(),
                                                              // alignment: Alignment.center,
                                                            ),
                                                            SizedBox(width: Dimensions.width10 / 2,),
                                                            GestureDetector(
                                                              onTap: (){
                                                                cartController.addItem(_cartList[index].product!, 1);
                                                                print("being tapped");
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors.grey.shade800,
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
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              );
                            },
                          ),
                        ),
                      ),
                    )
                        :
                    const SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: NoDataPage(
                            text: "السلة فارغة",
                            imgPath: 'assets/images/cart_empty.svg',
                          ),
                        );
                    }
                    ),
                  ],
                ),
              bottomNavigationBar: GetBuilder<CartController>(
                  builder: (cartController){
                    return Container(
                      height: Dimensions.bottomHeightBar,
                      padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20 * 2),
                          topRight: Radius.circular(Dimensions.radius20 * 2),
                        ),
                      ),
                      child: cartController.getItems.length > 0 ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: Dimensions.width10 / 2,),
                                CustomBigText(
                                  text: "\$ " + cartController.totalAmount.toString(),
                                  // alignment: Alignment.center,
                                ),
                                SizedBox(width: Dimensions.width10 / 2,),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              //popularProduct.addItem(product);
                              if(Get.find<AuthController>().userLoggedIn()){
                                print("logged in?");
                                // cartController.addToHistory();
                                if(Get.find<LocationController>().addressList.isEmpty){
                                  Get.toNamed(RouteHelper.getAddAddressPage());
                                }
                                else{
                                  Get.offNamed(RouteHelper.getInitial());
                                }
                              }else{
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                              cartController.addToHistory();
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: Dimensions.height45/1.9, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
                              child: CustomBigText(
                                text: " Check Out ",
                                color: Colors.white,
                              ),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(Dimensions.radius20),
                              //   color: Colors.blue,
                              // ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.blue.shade200,
                                boxShadow: [
                                  //darker shadow at bottom right
                                  BoxShadow(
                                      color: Colors.blue.shade700.withOpacity(0.7),
                                      offset: Offset(4, 4),
                                      blurRadius: 10,
                                      spreadRadius: 0.1
                                  ),

                                  //Lighter shadow at top right
                                  BoxShadow(
                                      color: Colors.blue.shade200,
                                      // offset: Offset(-4, -4),
                                      blurRadius: 1,
                                      // spreadRadius: 0.5
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue.shade200,
                                    Colors.blue.shade400
                                  ],
                                  stops: [
                                    0.1,
                                    0.9
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) :
                          Container(),
                    );
                  }
              ),
            ),
      ),
    );
  }
}
