import 'dart:async';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:theblue_crown/controllers/controller_lists/category_list_view_controller.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/custom_small_text.dart';

import '../../../animations/slide_animation.dart';
import '../../../constance.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/controller_lists/popular_product_controller.dart';
import '../../../routes/route_helper.dart';
import '../../../widgets/custom_big_text.dart';
import '../../cart/cart_page.dart';
import '../../cart/cart_short_view.dart';
import 'category_list_view.dart';

class CompanyOrFactoryView extends StatefulWidget {
  const CompanyOrFactoryView({Key? key}) : super(key: key);

  @override
  State<CompanyOrFactoryView> createState() => _CompanyOrFactoryViewState();
}

class _CompanyOrFactoryViewState extends State<CompanyOrFactoryView> with TickerProviderStateMixin{

  DateTime timeBackPressed = DateTime.now();

  final controller2 = HomeController();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller2.ChangeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller2.ChangeHomeState(HomeState.normal);
    }
  }


  late double _height;

  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);

  // _navigate() async {
  //   //Animate screen container from bottom to top
  //   await _animateContainerFromBottomToTop();
  //
  //   await Navigation.push(
  //     context,
  //     customPageTransition: PageTransition(
  //       child: const VendorScreen(),
  //       type: PageTransitionType.fadeIn,
  //     ),
  //   );
  //
  //   await _animateContainerFromTopToBottom();
  // }

  _animateContainerFromBottomToTop() async {
    //Animate back to default value
    _height = MediaQuery.of(context).padding.top + 50;
    setState(() {});

    //Wait till animation is finished
    await Future.delayed(_duration);
  }

  _animateContainerFromTopToBottom() async {
    //Wait
    await Future.delayed(_psudoDuration);

    //Animate from top to bottom
    _height = MediaQuery.of(context).size.height;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //Default height
    _height = 0;
    setState(() {});

    //Animate Container from Top to bottom
    Timer(const Duration(milliseconds: 50), () {
      _animateContainerFromTopToBottom();
    });
  }


  @override
  Widget build(BuildContext context) {
    // TabController _tabController =
    // TabController(length: 3, vsync: this);

    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: AnimatedBuilder(
            animation: controller2,
            builder: (context, snapshot) {
              return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return SlideAnimation(
                      begin: const Offset(0, 400),
                      duration: _duration,
                      child: AnimatedContainer(
                        height: _height,
                        duration: _duration,
                        padding: const EdgeInsets.only(bottom: 0.000001),
                        curve: Curves.fastOutSlowIn,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  //the header
                                  Column(
                                    children: [
                                      Container(
                                        height: Dimensions.height45 - 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: Dimensions.height30 * 2.5 + Dimensions.height10,
                                        width: double.maxFinite,
                                        //color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Center(
                                              child: Container(
                                                width: Dimensions.height45,
                                                height: Dimensions.height45,
                                                child: Lottie.asset('assets/search.json'),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: CustomBigText(
                                                text: "Labsa Class".tr,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){  Get.toNamed(RouteHelper.getInitial());  },
                                              child: const Icon(Icons.arrow_forward),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  //the body
                                  Container(
                                    //height: Dimensions.height10 / 3,
                                    width: double.maxFinite,
                                    color: Colors.white,
                                    padding: EdgeInsets.only(top: Dimensions.height10 / 2, right: Dimensions.height20, left: Dimensions.height20),
                                    child: CustomSmallText(
                                      text: "Companies / Factories".tr,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height20,),
                                  SizedBox(
                                    height: Dimensions.height45 * 15,
                                    child: const CategoryListView(),
                                  ),
                                ],
                              ),
                            ),
                            //the short cart
                            AnimatedPositioned(
                              duration: panelTransition,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              height: controller2.homeState == HomeState.normal
                                  ? cartBarHeight / 1.3
                                  : (constraints.maxHeight - cartBarHeight / 1.5),
                              child: GestureDetector(
                                onVerticalDragUpdate: _onVerticalGesture,
                                child: Container(
                                  padding: EdgeInsets.all(Dimensions.height10 / 1000),
                                  child: controller2.homeState == HomeState.normal
                                      ? CardShortView(controller2: controller2)
                                      : const CartPage(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
              );
            },
        ),
      ),
    );
  }
}