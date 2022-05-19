






import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theblue_crown/constance.dart';
import 'package:theblue_crown/utils/dimensions.dart';

import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller2 = HomeController();

  void _onHorizontalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller2.ChangeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller2.ChangeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller2,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: panelTransition,
                  top: 0,
                  right: 0,//- cartBarHeight *2 - 85,



                  left: controller2.homeState == HomeState.normal
                      ? constraints.maxHeight
                      : 0,



                  height: Dimensions.screenHeight,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: 20,
                    color: Colors.green,
                  ),
                ),
                AnimatedPositioned(
                  duration: panelTransition,
                  top: 100,
                  bottom: 100,
                  right: 300,


                  left: controller2.homeState == HomeState.normal
                  ? 0
                  : -constraints.maxHeight,



                  child: GestureDetector(
                    // onHorizontalDragUpdate: (details){
                    //   print(details.primaryDelta);
                    // },
                    onHorizontalDragUpdate: _onHorizontalGesture,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}























// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../utils/dimensions.dart';
// import '../../view/widgets/custom_big_text.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   bool isClicked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//       body: Padding(
//         padding: const EdgeInsets.all(120),
//         child: GestureDetector(
//               onTap: (){
//                 setState(() {
//                   isClicked = !isClicked;
//                 });
//               },
//               child: AnimatedSwitcher(
//                   duration: Duration(milliseconds: 600),
//                   child: isClicked ?
//                   Container(
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
//                     child: CustomBigText(
//                       text: "أضف إلى السلة",
//                       color: Colors.white,
//                       alignment: Alignment.center,
//                       size: Dimensions.font16,
//                     ),
//                   ) :
//                   Container(
//                     width: double.maxFinite,
//                     height: Dimensions.height20 * 1.75,
//                     margin: EdgeInsets.only(
//                       left: Dimensions.width20 / 2,
//                       right: Dimensions.width20 / 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                           Container(
//                             width: 30,
//                             height: 30,
//                             margin: EdgeInsets.only(
//                               left: Dimensions.width20 / 2,
//                               right: Dimensions.width20 / 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                             ),
//                             child: Icon(
//                               Icons.remove,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                         SizedBox(width: Dimensions.width10 / 2,),
//                         CustomBigText(
//                           text: "1", //popularProduct.inCartItems.toString(),
//                           alignment: Alignment.center,
//                         ),
//                         SizedBox(width: Dimensions.width10 / 2,),
//                         Container(
//                           width: 30,
//                           height: 30,
//                           margin: EdgeInsets.only(
//                             left: Dimensions.width20 / 2,
//                             right: Dimensions.width20 / 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(Dimensions.radius20 / 2.5),
//                           ),
//                           child: Icon(
//                               Icons.add,
//                               color: Colors.grey.shade800,
//                             ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

















// // import 'package:animation_2/constants.dart';
// // import 'package:animation_2/controllers/home_controller.dart';
// // import 'package:animation_2/models/Product.dart';
// // import 'package:animation_2/screens/deatils/details_screen.dart';
// // import 'package:animation_2/screens/home/components/cart_detailsview_card.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../constance.dart';
// import '../../controllers/home_controller.dart';
// import '../../utils/dimensions.dart';
// import '../../view/widgets/custom_big_text.dart';
// import '../../view/widgets/custom_small_text.dart';
// import 'advertisement_view.dart';
// // import 'components/cart_details_view.dart';
// // import 'components/cart_short_view.dart';
// // import 'components/header.dart';
// // import 'components/product_card.dart';
//
// // Today i will show you how to implement the animation
// // So starting project comes with the UI
// // Run the app
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   final controller2 = HomeController();
//
//   void _onVerticalGesture(DragUpdateDetails details) {
//     if (details.primaryDelta! < -0.7) {
//       controller2.ChangeHomeState(HomeState.cart);
//     } else if (details.primaryDelta! > 12) {
//       controller2.ChangeHomeState(HomeState.normal);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         bottom: false,
//         child: Container(
//           color: Color(0xFFEAEAEA),
//           child: AnimatedBuilder(
//             animation: controller2,
//             builder: (context, snapshot) {
//               return LayoutBuilder(
//                 builder: (context, BoxConstraints constraints) {
//                   return Stack(
//                   children: [
//                     //header
//                     AnimatedPositioned(
//                       duration: panelTransition,
//                       top: controller2.homeState == HomeState.normal
//                           ? 0
//                           : -headerHeight,
//                       right: 0,
//                       left: 0,
//                       height: headerHeight,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Center(
//                             child: Container(
//                               width: Dimensions.height45,
//                               height: Dimensions.height45,
//                               child: Lottie.asset('assets/search.json'),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(Dimensions.radius15),
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               CustomBigText(
//                                 text: "Country",
//
//                                 color: primaryColor,
//                               ),
//                               Row(
//                                 children: [
//                                   CustomSmallText(text: "City"),
//                                   Icon(Icons.arrow_drop_down),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           //const Icon(Icons.search_rounded, color: Colors.black87,),
//                           //const Text(
//                           //    "الصفحة الرئيسية", style: TextStyle(fontSize: 24, color: Colors.black87) ),
//                           InkWell(
//                             child: Container(
//                               height: Dimensions.height30 + 2,
//                               width: Dimensions.width30 + 2,
//                               child: Lottie.asset('assets/menu.json'),
//                             ),
//                             onTap: () {
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     //body
//                     AnimatedPositioned(
//                       duration: panelTransition,
//                       top: controller2.homeState == HomeState.normal
//                       ? headerHeight
//                       : -(constraints.maxHeight - cartBarHeight * 2 - headerHeight),
//                       right: 0,
//                       left: 0,
//                       height: constraints.maxHeight - headerHeight - cartBarHeight /2,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20.0),
//                             bottomRight: Radius.circular(20.0),
//                           )
//                         ),
//                         height: Dimensions.height45 * 15,
//                         child: SingleChildScrollView(
//                           physics: BouncingScrollPhysics(),
//                           child: AdvertisementView(),
//                         ),
//                       ),
//                     ),
//                     //cart panel
//                     AnimatedPositioned(
//                       duration: panelTransition,
//                       bottom: 0,
//                       right: 0,
//                       left: 0,
//                       height: controller2.homeState == HomeState.normal
//                       ? cartBarHeight / 1.5
//                       : (constraints.maxHeight - cartBarHeight),
//                         child: GestureDetector(
//                           onVerticalDragUpdate: _onVerticalGesture,
//                           child: Container(
//                             decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(20.0),
//                                   topLeft: Radius.circular(20.0),
//                                 ),
//                               color: Colors.blue,
//                             ),
//                             height: Dimensions.bottomHeightBar / 1.7,
//                             width: double.maxFinite,
//                             child: Padding(
//                               padding: const EdgeInsets.all(18.0),
//                               child: CustomBigText(
//                                 text: "السلة",
//                                 alignment: Alignment.topLeft,
//                                 size: 25,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               );
//             }
//           ),
//         ),
//       ),
//     );
//   }
// }
