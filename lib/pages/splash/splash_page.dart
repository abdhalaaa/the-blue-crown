import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/recommended_product_controller.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation <double> animation;
  late AnimationController controller;

  Future<void> _loadResource()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResource();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
    );
    Timer(
      const Duration(seconds: 3),
        ()=> Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(
                    'assets/images/bluesilver (2).jpg'
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: animation,
              child: Center(
                child: Image.asset(
                    "assets/images/splash.png",
                  width: Dimensions.splashImg,
                ),
              ),
            ),
          ),
          /*Center(
            child: Image.asset(
              "assets/images/splash.png",
              width: Dimensions.splashImg,
            ),
          ),*/
        ],
      ),
    );
  }
}
