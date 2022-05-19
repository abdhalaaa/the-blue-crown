import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/utils/app_constants.dart';
import 'package:theblue_crown/widgets/app_column.dart';
import 'package:theblue_crown/widgets/app_icon.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import 'package:theblue_crown/widgets/expandable_text.dart';

class DetailsView extends StatefulWidget {
  final int pageId ;
  final String page;

  const DetailsView({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

  String _cartTag = "";
  bool isClicked = true;

  @override
  Widget build(BuildContext context) {

    var product = Get.find<PopularProductController>().popularProductList[widget.pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              left: 0,
                right: 0,
                child: Hero(
                  tag: AppConstants.BASE_URL + AppConstants.UPLOAD_URL +product.img! + _cartTag,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: Dimensions.popularChmImgSize,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      child: CachedNetworkImage(
                        imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL +product.img!,
                        height: Dimensions.popularChmImgSize,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.black12,),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.black12,
                          child: const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            //icon widget
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                       if(widget.page == "cartpage"){
                         Get.toNamed(RouteHelper.getCartPage());
                       }else{
                         Get.toNamed(RouteHelper.getInitial());
                       }
                      },
                      child: const AppIcon(
                        icon: Icons.arrow_back_ios,
                      ),
                    ),
                    GetBuilder<PopularProductController>(builder: (controller) {
                          return GestureDetector(
                              onTap: (){
                                if(controller.totalItems >= 1)
                                  {Get.toNamed(RouteHelper.getCartPage());}
                                },
                            child: Stack(
                              children: [
                                const AppIcon(icon: Icons.shopping_cart_outlined,),
                                controller.totalItems >= 1 ?
                                const Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: Colors.blue,
                                  ),
                                ) :
                                Container(),
                                Get.find<PopularProductController>().totalItems >= 1 ?
                                Positioned(
                                  right: 4,
                                  top: 3,
                                  child: CustomBigText(text: Get.find<PopularProductController>().totalItems.toString(),
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ) :
                                Container(),
                              ],
                            ),
                          );
                        }
                    ),
                  ],
                ),
            ),
            //introduction
            Positioned(
               left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.popularChmImgSize - 20,
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20)
                      ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!, color: Colors.black,),
                      SizedBox(height: Dimensions.height20,),
                      CustomBigText(
                        text: "Details".tr,
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(
                            // text: "dgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsgdgsadegasdgadsgadsg",
                            text: product.description!
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct){
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),



              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(Dimensions.radius20),
              //         color: Colors.white,
              //       ),
              //       child: Row(
              //         children: [
              //           GestureDetector(
              //             onTap: (){
              //               popularProduct.setQuantity(false);
              //             },
              //             child: Icon(
              //               Icons.remove,
              //               color: Colors.grey.shade800,
              //             ),
              //           ),
              //           SizedBox(width: Dimensions.width10 / 2,),
              //           CustomBigText(
              //             text: popularProduct.inCartItems.toString(),
              //             alignment: Alignment.center,
              //           ),
              //           SizedBox(width: Dimensions.width10 / 2,),
              //           GestureDetector(
              //             onTap: (){
              //               popularProduct.setQuantity(true);
              //             },
              //             child: Icon(
              //               Icons.add,
              //               color: Colors.grey.shade800,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: (){
              //         popularProduct.addItem(product);
              //         Get.toNamed(RouteHelper.getInitial());
              //         setState(() {
              //           _cartTag = '_cartTag';
              //         });
              //       },
              //       child: Container(
              //         padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
              //         child: CustomBigText(
              //           text: "\$ ${product.price!} | Add To Cart ",
              //           color: Colors.white,
              //         ),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(Dimensions.radius20),
              //           color: Colors.blue,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),




                child: isClicked && popularProduct.checkQuantity(-1) == 0 || popularProduct.inCartItems.toString() == "0" ?
                //Add To Cart
                GestureDetector(
                    onTap: (){
                      popularProduct.setQuantity(true);
                      popularProduct.addItem(product);
                      setState(() {
                        isClicked = !isClicked;
                      });
                      },
                    child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 1.75,
                    margin: EdgeInsets.only(
                      left: Dimensions.width20 / 2,
                      right: Dimensions.width20 / 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
                    ),
                    child: Center(
                      child: CustomBigText(
                        text: "Add To Cart".tr,
                        color: Colors.white,
                        // alignment: Alignment.center,
                        size: Dimensions.font26,
                      ),
                    ),
                  )
                ) :
                //Remove And Add Container
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20 * 1.75,
                  margin: EdgeInsets.only(
                    left: Dimensions.width20 / 2,
                    right: Dimensions.width20 / 2,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
                  ),
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Add Icon
                      GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                          popularProduct.addItem(product);
                          setState(() {
                            isClicked = !isClicked;
                          });
                        },
                        child: Container(
                          width: Dimensions.width30 * 2,
                          height: double.infinity,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20 / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.width10 / 2,),
                      //inCartItems
                      CustomBigText(
                        text: popularProduct.inCartItems.toString(), //popularProduct.inCartItems.toString(),
                        // alignment: Alignment.center,
                      ),
                      SizedBox(width: Dimensions.width10 / 2,),
                      //Remove Icon
                      GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                          popularProduct.addItem(product);
                          setState(() {
                            isClicked = !isClicked;
                          });
                        },
                        child: Container(
                          width: Dimensions.width30 * 2,
                          height: double.infinity,
                          margin: EdgeInsets.only(
                            right: Dimensions.width20 / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),





            );
          }
        ),

        /*Container(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:370,
                child: Image.network(
                  model.image,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        CustomSmallText(
                          text: model.name,
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width * .42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CustomBigText(
                                    text: 'Size',
                                  ),
                                  CustomBigText(
                                    //text: model.sized,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width * .44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:  [
                                  CustomBigText(
                                    text: 'Color',
                                  ),
                                  CustomBigText(
                                    //text: model.sized,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomBigText(
                          text: 'Details',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBigText(
                          text: model.description,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomBigText(
                          text: "السعر",
                          color: Colors.grey,
                        ),
                        CustomBigText(
                          text: 'ج.م  ' + model.price ,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    GetBuilder<CartViewModel>(
                      init:Get.put(CartViewModel()),
                      builder: (controller) => Container(
                        padding: const EdgeInsets.all(20),
                        width: 180,
                        height: 100,
                        child: CustomButton(
                          onPressed: () => controller.addProduct(
                            CartProductModel(
                              name: model.name,
                              image: model.image,
                              price: model.price,
                              quantity: 1,
                              productid: model.productid,
                            ),
                          ),
                          text: 'Add to Cart',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),*/
        ),
    );
  }
}
