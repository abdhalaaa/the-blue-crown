import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/recommended_product_controller.dart';
import 'package:theblue_crown/pages/home/product_info_text.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/utils/app_constants.dart';
import 'package:theblue_crown/widgets/app_icon.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import 'package:theblue_crown/widgets/expandable_text.dart';

import '../../animations/fade_animation.dart';
import '../../animations/scale_animation.dart';
import '../../animations/slide_animation.dart';


class DetailsView3 extends StatefulWidget {
  // final int pageId ;
  // final String page;
  const DetailsView3({
    Key? key,
    // required this.pageId,
    // required this.page,
  }) : super(key: key);

  @override
  State<DetailsView3> createState() => _RecommendedDetailsState();
}

class _RecommendedDetailsState extends State<DetailsView3> {

  String _cartTag = "";

  @override
  Widget build(BuildContext context) {
    // var product = Get.find<RecommendedProductController>().recommendedProductList[widget.pageId];
    // Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getCompanyOrFactoryView());
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
                      // if(widget.page == "cartpage"){
                      //   Get.toNamed(RouteHelper.getCartPage());
                      // }else{
                      //   Get.toNamed(RouteHelper.getInitial());
                      // }
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  //AppIcon(icon: Icons.shopping_cart_outlined),
                  // GetBuilder<PopularProductController>(
                  //     builder: (controller){
                  //       return GestureDetector(
                  //         onTap: (){
                  //           if(controller.totalItems >= 1) {
                  //             Get.toNamed(RouteHelper.getCartPage());
                  //           }
                  //         },
                  //         child: Stack(
                  //           children: [
                  //             const AppIcon(
                  //               icon: Icons.shopping_cart_outlined,
                  //             ),
                  //             Get.find<PopularProductController>().totalItems >= 1
                  //                 ?
                  //             const Positioned(
                  //               right: 0,
                  //               top: 0,
                  //               child:AppIcon(
                  //                 icon: Icons.circle,
                  //                 size: 20,
                  //                 iconColor: Colors.transparent,
                  //                 backgroundColor: Colors.blue,
                  //               ),
                  //             )
                  //                 :
                  //             Container(),
                  //             Get.find<PopularProductController>().totalItems >= 1
                  //                 ?
                  //             Positioned(
                  //               right: 4,
                  //               top: 3,
                  //               child: CustomBigText(text: Get.find<PopularProductController>().totalItems.toString(),
                  //                 size: 14,
                  //                 color: Colors.white,
                  //               ),
                  //             )
                  //                 :
                  //             Container(),
                  //           ],
                  //         ),
                  //       );
                  //     }
                  // ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(15),
                child: FadeAnimation(
                  intervalStart: 0.04,
                  duration: const Duration(milliseconds: 1250),
                  child: SlideAnimation(
                    begin: const Offset(0, 280),
                    intervalStart: 0.4,
                    duration: const Duration(milliseconds: 1250),
                    child: Container(
                    child: Center(
                      child: CustomBigText(
                        //text: product.name!,
                        text: "سلفونيك سوبر الممتاز",
                        size: Dimensions.font26,
                      ),
                    ),
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                  ),)
                ),
              ),
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              pinned: true,
              backgroundColor: Colors.white,
              expandedHeight: 420,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'assets/images/gmdana.png',
                  child: SizedBox(
                      height: Dimensions.height45 * 8,
                      child: Stack(
                        children: [

                          //yellow back shape
                          Positioned(
                            top: 0,
                            bottom: Dimensions.height45 * 3 - Dimensions.height15,
                            left: 0,
                            right: Dimensions.width30 * Dimensions.width5,
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: double.infinity,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xFFf7c72a),
                                // color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                ),
                              ),
                            ),
                          ),

                          //The Image
                          Positioned.fill(
                            top: 0,
                            bottom: -20,
                            left: -Dimensions.width30,
                            child: ScaleAnimation(
                              begin: 0,
                              duration: const Duration(milliseconds: 1000),
                              intervalStart: 0.2,
                              curve: Curves.easeOutBack,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                // child: ClipRRect(
                                //   borderRadius: BorderRadius.circular(Dimensions.radius20),
                                //   child: CachedNetworkImage(
                                //     imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + superElMomtazLabsa.superElMomtazLabsaList[index].img!,
                                //     height: Dimensions.listViewImgSize,
                                //     width:Dimensions.listViewImgSize,
                                //     fit: BoxFit.fill,
                                //     placeholder: (context, url) => Container(color: Colors.black12,),
                                //     errorWidget: (context, url, error) => Container(
                                //       color: Colors.black12,
                                //       child: const Icon(Icons.error, color: Colors.red),
                                //     ),
                                //   ),
                                // ),
                                child: Image.asset(
                                  // 'assets/images/fanos 11.png',
                                  // 'assets/images/labsa2.png',
                                  'assets/images/gmdana.png',
                                  width: Dimensions.width30  * 11.5,
                                ),
                              ),
                            ),
                          ),

                          //Food Info
                          Positioned.fill(
                            top: Dimensions.height10 / 20,
                            bottom: 0,
                            right: Dimensions.width30 + Dimensions.width10,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FadeAnimation(
                                duration: const Duration(milliseconds: 1250),
                                child: ScaleAnimation(
                                  intervalStart: 0.10,
                                  duration: const Duration(milliseconds: 1250),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      ProductInfoText(
                                        text: 'الوزن',
                                        value: '60 KG',
                                      ),
                                      ProductInfoText(
                                        text: 'المنشأ',
                                        value: 'مصر',
                                      ),
                                      ProductInfoText(
                                        text: 'التركيز',
                                        value: '85 %',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FadeAnimation(
                intervalStart: 0.04,
                duration: const Duration(milliseconds: 1250),
                child: SlideAnimation(
                  begin: const Offset(0, 220),
                  intervalStart: 0.6,
                  duration: const Duration(milliseconds: 1250),
                  child: Column(
                    children: [
                      Container(
                        child: const SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: ExpandableText(
                            // text: product.description! +
                            // text: "asfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsdasfsfasfasdfgadsgasdgadsgadgagadgadghadgadfhadfhadhadhadhadfrhadfsdfhsdfhdfhhsd",),
                        text: "تحضيرهيتولد حمض السلفونيك بعملية السلفنة. عامل السلفنة عادة هو ثلاثي أكسيد الكبريت. التطبيق الخاص الواسع الطيف لهذه الطريقة هو إنتاج حموض ألكيل البنزين المسلفنة.RC6H5 + SO3 → RC6H4SO3Hفي هذ التفاعل، ثلاثي أكسيد الكبريت هو شغوف بالإلكترون ويخضع الأرين إلى عملية استبدال عطري شغوف بالإلكترونات.يمكن أكسدة الثيولات لتتحول إلى حموض سلفونيك:RSH + 3/2 O2 → RSO3Hالتطبيقاتمع أن الحموض السلفونية الألكيلية والأريلية معروفة، إلا أن معظم التطبيقات مرتبطة بالمشتقات العطرية.المنظفات والفاعلات بالسطحالمنظفات والمواد الفاعلة بالسطح هي جزيئات تتضمن مجموعات عالية القطبية وأخرى لاقطبية. الصابون هو فاعل بالسطح معروف مشتق من الحموض الدسمة. منذ منتصف القرن العشرين، تفوق استخدام حموض السلفونيك على الصابون في المجتمعات المتطورة. فمثلا، ينتج مليوني كيلوغرام من سلفونات ألكيل البنزين سنويًا لأغراض متعددة. سلفونات الليغنين هي مكونات في سوائل الثقب ومواد مضافة لبعض أنواع الخرسانة.الأصبغةالعديد إن لم يكن معظم أصبغة الأنثراكينون تنتج أو تعالج بالسلفنة  تميل حموض السلفونيك للارتباط الوثيق مع البروتينات والكربوهيدرات. معظم الأصبغة القابلة للغسل هي حموض سلفونيك (أو تمتلك مجموعة سولفونيل) لهذا السبب. الأصبغة المباشرة في أغلبها تتضمن مجموعات السلفونيل، وهي تساعد على انحلالية الصباغ في حوض الصباغة لتسهيل انتقاله إلى الألياف النسيجية كالقطن.الأدويةأدوية سلفوناميد المضادة للبكتريا منتجة من حموض السلفونيك.",)
      ),
                        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
            builder: (popularProduct){
              return Container(
                height: Dimensions.bottomHeightBar / 1.25,
                padding: EdgeInsets.only(top: Dimensions.height30,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 1.5),
                    topRight: Radius.circular(Dimensions.radius20 * 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        left: Dimensions.width15,
                        right: Dimensions.width15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(false);
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(width: Dimensions.width30,),
                          CustomBigText(
                            text: popularProduct.inCartItems.toString(),
                            // alignment: Alignment.center,
                          ),
                          SizedBox(width: Dimensions.width30,),
                          GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // popularProduct.addItem(product);
                        // Get.toNamed(RouteHelper.getInitial());
                        // setState(() {
                        //   _cartTag = '_cartTag';
                        // });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width10,
                          right: Dimensions.width10,),
                        child: CustomBigText(
                          // text: "\$ ${product.price!} | أضف للسلة ",
                          text: "1800 | أضف للسلة ",
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius20),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}


































// import 'package:flutter/material.dart';
// import 'package:theblue_crown/pages/home/product_info_text.dart';
// import 'package:theblue_crown/utils/dimensions.dart';
// import '../../animations/fade_animation.dart';
// import '../../animations/scale_animation.dart';
// import '../../animations/slide_animation.dart';
// import '../../controllers/popular_product_controller.dart';
// import '../../utils/navigation.dart';
// import '../../view/widgets/custom_big_text.dart';
// import 'package:get/get.dart';
//
// import '../../view/widgets/expandable_text.dart';
// class ProductScreen extends StatefulWidget {
//
//   // final int pageId ;
//   // final String page;
//
//   const ProductScreen({
//     Key? key,
//     // required this.pageId,
//     // required this.page,
//   }) : super(key: key);
//
//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   final width = Dimensions.width30 * Dimensions.width5;
//   late double _height;
//
//   final _duration = const Duration(milliseconds: 750);
//   final _psudoDuration = const Duration(milliseconds: 150);
//
//   _navigateBack() async {
//     await _animateContainerFromBottomToTop();
//
//     Navigation.pop(context);
//   }
//
//   _animateContainerFromBottomToTop() async {
//     //Animate back to default value
//     _height = MediaQuery.of(context).padding.top + 50;
//     setState(() {});
//
//     //Wait till animation is finished
//     await Future.delayed(_duration);
//   }
//
//   _animateContainerFromTopToBottom() async {
//     //Wait
//     await Future.delayed(_psudoDuration);
//
//     //Animate from top to bottom
//     _height = MediaQuery.of(context).size.height;
//     setState(() {});
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     //Default height
//
//     _height = MediaQuery.of(context).padding.top + 50;
//     setState(() {});
//
//     //Animate Container from Top to bottom
//     _animateContainerFromTopToBottom();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Theme.of(context).primaryColor,
//       backgroundColor: Colors.blue,
//       body: AnimatedContainer(
//         height: _height,
//         duration: _duration,
//         padding: EdgeInsets.only(bottom: Dimensions.height10 / 3),
//         curve: Curves.fastOutSlowIn,
//         decoration: BoxDecoration(
//           color: Theme.of(context).scaffoldBackgroundColor,
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(Dimensions.radius20 * 2),
//             bottomLeft: Radius.circular(Dimensions.radius20 * 2),
//           ),
//         ),
//
//
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //The upper part
//               Container(
//                 height: Dimensions.height45 * 2,
//                 width: Dimensions.screenWidth - width,
//                 color: const Color(0xFFf7c72a),
//                 // color: Colors.green,
//               ),
//               SizedBox(
//                 height: Dimensions.height45 * 8,
//                 child: Stack(
//                   children: [
//                     //yellow back shape
//                     Positioned(
//                       top: 0,
//                       bottom: Dimensions.height45 * 2 - Dimensions.height15,
//                       left: 0,
//                       right: width,
//                       child: Container(
//                         alignment: Alignment.topLeft,
//                         height: double.infinity,
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFFf7c72a),
//                           // color: Colors.red,
//                           borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(50),
//                           ),
//                         ),
//                       ),
//                     ),
//                     //The Image
//                     Positioned.fill(
//                       top: 0,
//                       bottom: 0,
//                       left: -Dimensions.width30 * 2.1,
//                       child: ScaleAnimation(
//                         begin: 0,
//                         duration: const Duration(milliseconds: 1000),
//                         intervalStart: 0.2,
//                         curve: Curves.easeOutBack,
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Image.asset(
//                             'assets/images/gmdana.png',
//                             // 'assets/images/labsa2.png',
//                             width: Dimensions.width30 * 13.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                     //Food Info
//                     Positioned.fill(
//                       top: Dimensions.height10 / 20,
//                       bottom: 0,
//                       right: Dimensions.width30 + Dimensions.width10,
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: FadeAnimation(
//                           duration: const Duration(milliseconds: 1250),
//                           child: ScaleAnimation(
//                             intervalStart: 0.4,
//                             duration: const Duration(milliseconds: 1250),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const <Widget>[
//                                 ProductInfoText(
//                                   text: 'الوزن',
//                                   value: '60 KG',
//                                 ),
//                                 ProductInfoText(
//                                   text: 'المنشأ',
//                                   value: 'مصر',
//                                 ),
//                                 ProductInfoText(
//                                   text: 'التركيز',
//                                   value: '85 %',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               //the middle part
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: FadeAnimation(
//                         intervalStart: 0.4,
//                         duration: const Duration(milliseconds: 1300),
//                         child: SlideAnimation(
//                           intervalStart: 0.4,
//                           begin: const Offset(0, 80),
//                           duration: const Duration(milliseconds: 1300),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 'Raspberry Donut',
//                                 style: Theme.of(context).textTheme.headline4,
//                               ),
//                               const SizedBox(height: 20),
//                               Text(
//                                 '\$12.95',
//                                 style:
//                                 Theme.of(context).textTheme.headline4!.copyWith(
//                                   color: Theme.of(context).primaryColorDark,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               const ExpandableText(
//                                 text: 'lorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetorem ipsum doremet',
//                               ),
//                               // Text(
//                               //   'lorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetloremlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetlorem ipsum doremetorem ipsum doremet',
//                               //   style: Theme.of(context).textTheme.bodyText2,
//                               // ),
//                             ],
//                           ),
//                         ),
//                     ),
//               ),
//             ],
//           ),
//         )
//       ),
//       bottomNavigationBar: GetBuilder<PopularProductController>(
//           builder: (popularProduct){
//             return Container(
//               height: Dimensions.bottomHeightBar / 1.25,
//               padding: EdgeInsets.only(top: Dimensions.height30,
//                 bottom: Dimensions.height20,
//                 left: Dimensions.width20,
//                 right: Dimensions.width20,),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(Dimensions.radius20 * 2),
//                   topRight: Radius.circular(Dimensions.radius20 * 2),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(
//                       top: Dimensions.height10,
//                       bottom: Dimensions.height10,
//                       left: Dimensions.width15,
//                       right: Dimensions.width15,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           Dimensions.radius20),
//                       color: Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             popularProduct.setQuantity(false);
//                           },
//                           child: Icon(
//                             Icons.remove,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                         SizedBox(width: Dimensions.width30,),
//                         CustomBigText(
//                           text: popularProduct.inCartItems.toString(),
//                           alignment: Alignment.center,
//                         ),
//                         SizedBox(width: Dimensions.width30,),
//                         GestureDetector(
//                           onTap: () {
//                             popularProduct.setQuantity(true);
//                           },
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // popularProduct.addItem(product);
//                       // Get.toNamed(RouteHelper.getInitial());
//                       // setState(() {
//                       //   _cartTag = '_cartTag';
//                       // });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.only(
//                         top: Dimensions.height10,
//                         bottom: Dimensions.height10,
//                         left: Dimensions.width10,
//                         right: Dimensions.width10,),
//                       child: CustomBigText(
//                         // text: "\$ ${product.price!} | أضف للسلة ",
//                         text: "1800 | أضف للسلة ",
//                         color: Colors.white,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                             Dimensions.radius20),
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//       ),
//     );
//   }
// }