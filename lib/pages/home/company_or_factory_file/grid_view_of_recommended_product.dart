import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/routes/route_helper.dart';

import '../../../controllers/cart_controller.dart';
import '../../../controllers/controller_lists/el_momtaz_labsa_controller.dart';
import '../../../controllers/controller_lists/super_el_momtaz_labsa_controller.dart';
import '../../../controllers/controller_lists/recommended_product_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/custom_big_text.dart';
import '../../../widgets/custom_small_text.dart';

class GridViewOfSuperElMomtazLabsa extends StatefulWidget {

  final int pageId ;

  const GridViewOfSuperElMomtazLabsa({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  State<GridViewOfSuperElMomtazLabsa> createState() => _GridViewOfSuperElMomtazLabsaState();
}

class _GridViewOfSuperElMomtazLabsaState extends State<GridViewOfSuperElMomtazLabsa> {
  final numbers = List.generate(6, (index) => '$index');

  final controller = ScrollController();

  bool isClicked = true;


  @override
  Widget build(BuildContext context) {

    var product = Get.find<SuperElMomtazLabsaController>().superElMomtazLabsaList[widget.pageId];
    Get.find<SuperElMomtazLabsaController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      //backgroundColor: Colors.black,

      body: GetBuilder<SuperElMomtazLabsaController>(
          builder: (ElMomtazLabsa) {
            return ElMomtazLabsa.isLoaded ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height45,
                  child: Padding(
                    padding: EdgeInsets.only(top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        right: Dimensions.width10,
                        left: Dimensions.width10),
                    child: CustomBigText(
                      // text: " يوجد " + ElMomtazLabsa.superElMomtazLabsaList.length.toString() + " منتج",
                      text: "There is ".tr + ElMomtazLabsa.superElMomtazLabsaList.length.toString() + (ElMomtazLabsa.superElMomtazLabsaList.length.toString() != 1 ? " product".tr : " products".tr),
                      size: 15,
                    ),
                  ),
                  //color: Colors.red,
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.35,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    padding: const EdgeInsets.all(12),
                    controller: controller,
                    itemCount: ElMomtazLabsa.superElMomtazLabsaList.length,
                    //itemCount: 10,
                    itemBuilder: (context, index) {
                      final item = numbers[index];

                      return GestureDetector(
                        onTap: (){  Get.toNamed(RouteHelper.getSuperElMomtazLabsaFood(index, "home"));  },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20 / 5,
                            right: Dimensions.width20 / 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.grey[400],
                          ),
                          padding: const EdgeInsets.all(1),

                          child: Column(
                            children: [
                              SizedBox(
                                width: Dimensions.screenWidth,
                                height: Dimensions.listViewImgSize / 1.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + ElMomtazLabsa.superElMomtazLabsaList[index].img!,
                                    height: Dimensions.listViewImgSize,
                                    width:Dimensions.listViewImgSize,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Container(color: Colors.black12,),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.black12,
                                      child: const Icon(Icons.error, color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.height10 / 2,),
                              SizedBox(
                                //color: Colors.blue,
                                height: Dimensions.height45 * 2.25,
                                width: double.maxFinite,
                                //color: Colors.green,
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Center(
                                    child: CustomSmallText(
                                      text: "السلفونيك",
                                      // alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.height10 / 2,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isClicked = !isClicked;
                                  });
                                },
                                child: isClicked && ElMomtazLabsa.checkQuantity(-1) == 0 || ElMomtazLabsa.inCartItems.toString() == "0" ?
                                //Add To Cart
                                GestureDetector(
                                    onTap: (){
                                      ElMomtazLabsa.setQuantity(true);
                                      ElMomtazLabsa.addItem(product);
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
                                        child: CustomSmallText(
                                          text: "Add To Cart".tr,
                                          color: Colors.white,
                                          // alignment: Alignment.center,
                                          size: Dimensions.font16 * 1.1,
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
                                          ElMomtazLabsa.setQuantity(true);
                                          ElMomtazLabsa.addItem(product);
                                          setState(() {
                                            isClicked = !isClicked;
                                          });
                                        },
                                        child: Container(
                                          width: Dimensions.width30 * 1.2,
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
                                        text: ElMomtazLabsa.inCartItems.toString(), //popularProduct.inCartItems.toString(),
                                        // alignment: Alignment.center,
                                      ),
                                      SizedBox(width: Dimensions.width10 / 2,),
                                      //Remove Icon
                                      GestureDetector(
                                        onTap: (){
                                          ElMomtazLabsa.setQuantity(false);
                                          ElMomtazLabsa.addItem(product);
                                          setState(() {
                                            isClicked = !isClicked;
                                          });
                                        },
                                        child: Container(
                                          width: Dimensions.width30 * 1.2,
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
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ) : const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
      ),
    );
  }


// Widget buildGridView() =>  ;

// Widget buildNumber(String number, int index, superElMomtazLabsa) => GestureDetector(
//   onTap: (){  Get.toNamed(RouteHelper.getSuperElMomtazLabsaFood(index, "home"));  },
//   child: Container(
//       margin: EdgeInsets.only(
//         left: Dimensions.width20 / 5,
//         right: Dimensions.width20 / 5,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(Dimensions.radius20),
//         color: Colors.grey[400],
//       ),
//       padding: const EdgeInsets.all(1),
//
//       child: Column(
//         children: [
//           SizedBox(
//             width: Dimensions.screenWidth,
//             height: Dimensions.listViewImgSize / 1.25,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(Dimensions.radius20),
//               child: CachedNetworkImage(
//                 imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + superElMomtazLabsa.superElMomtazLabsaList[index].img!,
//                 height: Dimensions.listViewImgSize,
//                 width:Dimensions.listViewImgSize,
//                 fit: BoxFit.fill,
//                 placeholder: (context, url) => Container(color: Colors.black12,),
//                 errorWidget: (context, url, error) => Container(
//                   color: Colors.black12,
//                   child: const Icon(Icons.error, color: Colors.red),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: Dimensions.height10 / 2,),
//           SizedBox(
//             //color: Colors.blue,
//             height: Dimensions.height45 * 2.25,
//             width: double.maxFinite,
//             //color: Colors.green,
//             child: const Padding(
//               padding: EdgeInsets.only(top: 8),
//               child: Center(
//                 child: CustomSmallText(
//                   text: "السلفونيك",
//                   // alignment: Alignment.center,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: Dimensions.height10 / 2,),
//           GestureDetector(
//             onTap: (){
//               setState(() {
//                 isClicked = !isClicked;
//               });
//             },
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 600),
//
//
//               child: isClicked && ElMomtazLabsa.checkQuantity(-1) == 0 || ElMomtazLabsa.inCartItems.toString() == "0" ?
//               //Add To Cart
//               GestureDetector(
//                   onTap: (){
//                     popularProduct.setQuantity(true);
//                     popularProduct.addItem(product);
//                     setState(() {
//                       isClicked = !isClicked;
//                     });
//                   },
//                   child: Container(
//                     width: double.maxFinite,
//                     height: Dimensions.height20 * 1.75,
//                     margin: EdgeInsets.only(
//                       left: Dimensions.width20 / 2,
//                       right: Dimensions.width20 / 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                     ),
//                     child: Center(
//                       child: CustomBigText(
//                         text: "Add To Cart".tr,
//                         color: Colors.white,
//                         // alignment: Alignment.center,
//                         size: Dimensions.font26,
//                       ),
//                     ),
//                   )
//               ) :
//               //Remove And Add Container
//               Container(
//                 width: double.maxFinite,
//                 height: Dimensions.height20 * 1.75,
//                 margin: EdgeInsets.only(
//                   left: Dimensions.width20 / 2,
//                   right: Dimensions.width20 / 2,
//                 ),
//                 decoration: BoxDecoration(
//                   // color: Colors.red,
//                   borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                 ),
//                 child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     //Remove Icon
//                     GestureDetector(
//                       onTap: (){
//                         popularProduct.setQuantity(false);
//                         popularProduct.addItem(product);
//                         setState(() {
//                           isClicked = !isClicked;
//                         });
//                       },
//                       child: Container(
//                         width: Dimensions.width30 * 2,
//                         height: double.infinity,
//                         margin: EdgeInsets.only(
//                           right: Dimensions.width20 / 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                         ),
//                         child: const Icon(
//                           Icons.remove,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: Dimensions.width10 / 2,),
//                     //inCartItems
//                     CustomBigText(
//                       text: popularProduct.inCartItems.toString(), //popularProduct.inCartItems.toString(),
//                       // alignment: Alignment.center,
//                     ),
//                     SizedBox(width: Dimensions.width10 / 2,),
//                     //Add Icon
//                     GestureDetector(
//                       onTap: (){
//                         popularProduct.setQuantity(true);
//                         popularProduct.addItem(product);
//                         setState(() {
//                           isClicked = !isClicked;
//                         });
//                       },
//                       child: Container(
//                         width: Dimensions.width30 * 2,
//                         height: double.infinity,
//                         margin: EdgeInsets.only(
//                           left: Dimensions.width20 / 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                         ),
//                         child: const Icon(
//                           Icons.add,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ),
//           ],
//         ),
//       ),
//   );
// }
}