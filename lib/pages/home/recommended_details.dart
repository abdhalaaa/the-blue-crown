import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/recommended_product_controller.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/utils/app_constants.dart';
import 'package:theblue_crown/widgets/app_icon.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import 'package:theblue_crown/widgets/expandable_text.dart';


class RecommendedDetails extends StatefulWidget {
  final int pageId ;
  final String page;
  const RecommendedDetails({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  State<RecommendedDetails> createState() => _RecommendedDetailsState();
}

class _RecommendedDetailsState extends State<RecommendedDetails> {

  String _cartTag = "";

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[widget.pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
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
                    child: const AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<PopularProductController>(
                      builder: (controller){
                        return GestureDetector(
                          onTap: (){
                            if(controller.totalItems >= 1) {
                              Get.toNamed(RouteHelper.getCartPage());
                            }
                          },
                          child: Stack(
                            children: [
                              const AppIcon(
                                icon: Icons.shopping_cart_outlined,
                              ),

                              Get.find<PopularProductController>().totalItems >= 1 ?
                              const Positioned(
                                right: 0,
                                top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: Colors.blue,
                                  ),
                              ) : Container(),

                              Get.find<PopularProductController>().totalItems >= 1 ?
                              Positioned(
                                right: 4,
                                top: 3,
                                child: CustomBigText(text: Get.find<PopularProductController>().totalItems.toString(),
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ) : Container(),
                            ],
                          ),
                        );
                      }
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                  child: CustomBigText(
                      text: product.name!,
                    size: Dimensions.font26,
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    child: CachedNetworkImage(
                      imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                      height: Dimensions.listViewImgSize,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.black12,),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black12,
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  // child: Image.network(
                  //     AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                  //   width: double.maxFinite,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExpandableText(
                        text: product.description! + "asfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsd",),
                    ),
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          icon: Icons.add,
                          backgroundColor: Colors.blueAccent,
                          iconColor: Colors.white,
                          iconsize: Dimensions.iconSize24,
                        ),
                      ),
                      CustomBigText(
                        text: "\$ ${product.price!}  X  ${controller.inCartItems} ",
                        color: Colors.black,
                        size: Dimensions.font26,
                      ),
                      GestureDetector(
                        onTap: (){
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                          icon: Icons.remove,
                          backgroundColor: Colors.blueAccent,
                          iconColor: Colors.white,
                          iconsize: Dimensions.iconSize24,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.blueAccent,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          controller.addItem(product);
                          Get.toNamed(RouteHelper.getInitial());
                          setState(() {
                            _cartTag = '_cartTag';
                          });
                        },
                        child: Container (
                          padding: EdgeInsets.only(top: Dimensions.height45 / 2, bottom: Dimensions.height45 / 2, left: Dimensions.width20, right: Dimensions.width20,),
                          child: CustomBigText(
                            text: "\$${product.price!} | Add To Cart ".tr,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
