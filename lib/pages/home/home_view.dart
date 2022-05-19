import 'dart:async';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:theblue_crown/constance.dart';
import 'package:theblue_crown/controllers/home_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/recommended_product_controller.dart';
import 'package:theblue_crown/pages/cart/cart_page.dart';
import 'package:theblue_crown/pages/cart/cart_short_view.dart';
import 'package:theblue_crown/pages/home/wallet_view.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import 'package:theblue_crown/widgets/custom_small_text.dart';
import '../../animations/page_transition.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/image_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/navigation.dart';
import '../account/account_page.dart';
import '../address/add_address_page.dart';
import '../auth/sign_in_page.dart';
import '../cart/cart_history.dart';
import '../cart/cart_page.dart';
import '../settings/settings.dart';
import 'advertisement_view.dart';
import 'company_or_factory_file/company_or_factory_view.dart';

const Color backgroundColor =  Colors.blue;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  final controller2 = HomeController();
  final double advertisementHeight = 400;
  final double sectionsHeight = Dimensions.height45 * 3.5 * 2.5;
  final double bestSellingHeight = Dimensions.height10;
  bool isCollapsed = true;
  double? screenWidth;
  double? screenHeight;
  final Duration duration = const Duration(milliseconds: 200);
  AnimationController? _controller;
  late Animation<double> _scaleAnimation, _smallScaleAnimation, _verySmallScaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late double _height;
  final _duration = const Duration(milliseconds: 750);
  final _psudoDuration = const Duration(milliseconds: 150);



  _navigate() async {
    //Animate screen container from bottom to top
    await _animateContainerFromBottomToTop();

    await Navigation.push(
      context,
      customPageTransition: PageTransition(
        child: const CompanyOrFactoryView(),
        type: PageTransitionType.fadeIn,
      ),
    );

    await _animateContainerFromTopToBottom();
  }

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller2.ChangeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller2.ChangeHomeState(HomeState.normal);
    }
  }

  Future<void> _loadResource()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

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
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller!);
    _smallScaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller!);
    _verySmallScaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller!);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller!);
    _slideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
            //resizeToAvoidBottomInset : false,
            //body: SingleChildScrollView(
      backgroundColor: Colors.blue,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          duration: const Duration(milliseconds: 900),
          content: Text('Tap back again to leave'.tr),
        ),
        child: AnimatedBuilder(
            animation: controller2,
            builder: (context, snapshot) {
              return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return Stack(
                      children: <Widget>[
                        menu(context),
                        dashboard(context),
                        dashboard2(context),
                        dashboard3(context, constraints),
                        customcartview (context, constraints, controller2),
                      ],
                    );
                  }
                  );
            }
            ),
      ),
    );
  }

  Widget menu (context) {

    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      //print("User has logged in");
    }
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.height30,left: Dimensions.width15),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[


                GetBuilder<UserController>(builder: (userController) {
                  return _userLoggedIn ?
                  (userController.isLoading ?
                  Container(
                    height: Dimensions.height45 + Dimensions.height45,
                    color: Colors.blue,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: Dimensions.height30,
                        right: Dimensions.width30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Dimensions.height15),
                          child: SizedBox(
                            height: Dimensions.height45,
                            // child: CustomSmallText(
                            //     text: "عبد الرحمن الريدي",
                            //     color: Colors.white,
                            //     size: 15,
                            //   ),
                            child: CustomBigText(
                              text: userController.userModel!.name,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width15,),
                        Container(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            height: Dimensions.height30 * 2,
                            width: Dimensions.width30 * 2,
                            child: Lottie.asset('assets/profilePerson.json'),
                          ),
                        ),
                      ],
                    ),
                  ) : Container(
                    height: Dimensions.height45 + Dimensions.height45,
                    color: Colors.blue,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: Dimensions.height30,
                        right: Dimensions.width30),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: Dimensions.height30 * 2,
                        width: Dimensions.width30 * 2,
                        child: Lottie.asset('assets/profilePerson.json'),
                      ),
                    ),
                  )
                  ) : Container(
                    height: Dimensions.height45 + Dimensions.height45,
                    color: Colors.blue,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: Dimensions.height30,
                        right: Dimensions.width30),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: Dimensions.height30 * 2,
                        width: Dimensions.width30 * 2,
                        child: Lottie.asset('assets/profilePerson.json'),
                      ),
                    ),
                  );
                  },
                ),
                // SizedBox(height: Dimensions.height45 * 3 + Dimensions.height20),
                SizedBox(height: Dimensions.height20 / 2),

                //select image
                GetBuilder<ImageController>(builder:(imageController) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => imageController.pickImage(),
                              child: SizedBox(
                                width: Dimensions.width30 * 4,
                                child: const Center(
                                  child: CustomSmallText(
                                    text: 'Select An Image',
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              // width: double.infinity,
                              width: Dimensions.width30 * 5,
                              height: Dimensions.height45 * 2.5,
                              color: Colors.grey[300],
                              child: Get.find<ImageController>().pickedFile != null
                                  ? Image.file(File(Get.find<ImageController>().pickedFile!.path),
                                // width: Dimensions.width30 * 3.5,
                                // height: Dimensions.height45 * 2.5,
                                fit: BoxFit.fill,
                              )
                                  : const Center(child: Text('Please select an image')),
                            )
                          ]
                  );
                }
                ),
                SizedBox(height: Dimensions.height10 / 2),

                //upload image to server
                GetBuilder<ImageController>(builder:(_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: Dimensions.width30 * 4,
                        child: GestureDetector(
                          // child: const Text('Server upload'),
                          //onPressed: _openImagePicker,
                          child: const Center(
                            child: CustomSmallText(
                              text: 'Server upload',
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          onTap:()=> Get.find<ImageController>().upload(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Dimensions.width30 * 5,
                        height: Dimensions.height45 * 2.5,
                        color: Colors.grey[300],
                        child: Get.find<ImageController>().imagePath != null
                            ? Image.network(
                          "http://mvs.bslmeiyu.com"
                              // "http://10.0.2.2:8000"
                              +Get.find<ImageController>().imagePath!,
                          // width: 100, height: 100,
                          fit: BoxFit.fill,
                        )
                            : const Center(child: Text('No image from server')),
                      ),
                    ],
                  );
                }
                ),


                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(Dimensions.height10),
                  height: Dimensions.height30 * 2,
                  width: Dimensions.width30 * 6.5,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const CartHistory(), transition: Transition.fade),
                          text: "Order History".tr,
                          style: TextStyle( color: Colors.white, fontSize: Dimensions.font20,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.width25 / 2, top: Dimensions.height15 / 2, bottom: Dimensions.height15 / 2),
                        child: Lottie.asset(
                          'assets/lastOrders.json',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(Dimensions.height10),
                  height: Dimensions.height30 * 2,
                  width: Dimensions.width30 * 10,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=> const WalletView());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Dimensions.width30 * 3,
                          height: Dimensions.height45 * 2,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                            child: CustomBigText(
                              text:  "0.0  ""E.p".tr ,
                              color: Colors.blue,
                              size: Dimensions.font20,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const WalletView(), transition: Transition.fade),
                            text: "The Wallet".tr,
                            style: TextStyle( color: Colors.white, fontSize: Dimensions.font20,),
                          ),
                        ),
                        Lottie.asset(
                          'assets/wallet.json',
                          //controller: _controller,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const CartPage());
                  },
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(Dimensions.height10),
                    height: Dimensions.height30 * 2,
                    width: Dimensions.width30 * 10,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            //recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>CartPage(), transition: Transition.fade),
                            text: "Notifications".tr,
                            style: TextStyle( color: Colors.white, fontSize: Dimensions.font20,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width5),
                          child: Lottie.asset('assets/notification.json'),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Get.to(()=> const AccountPage());
                  },
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(Dimensions.height10),
                    height: Dimensions.height30 * 2,
                    width: Dimensions.width30 * 10,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>AccountPage(), transition: Transition.fade),
                            text: "Profile".tr,
                            style: TextStyle( color: Colors.white, fontSize: Dimensions.font20,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width5),
                          child: Lottie.asset('assets/suggest.json'),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: Dimensions.height45 * 3 + Dimensions.height30),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const AddAddressPage());
                  },
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(Dimensions.height10),
                    height: Dimensions.height30 * 2,
                    width: Dimensions.width30 * 10,
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const AddAddressPage(), transition: Transition.fade),
                            text: "Complaints and suggestions".tr,
                            style: TextStyle( color: Colors.white, fontSize: Dimensions.font16 * 1.1,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width5),
                          child: Lottie.asset('assets/suggest.json'),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){  Get.to(()=> const SettingsView());},
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(Dimensions.height10),
                    height: Dimensions.height30 * 2,
                    width: Dimensions.width30 * 10,
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SettingsView(), transition: Transition.fade),
                            text: "Settings".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font20,
                            ),
                            children: const [
                              // TextSpan(
                              //   recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignInPage(), transition: Transition.fade),
                              //   text: "   تسجيل الخروج",
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.white,
                              //     fontSize: Dimensions.font20,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.width5 / 2,),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width5),
                          child: Lottie.asset('assets/settings.json'),
                        ),
                      ],
                    ),
                  ),
                ),
             ],
            ),
          ),
        ),
      ),
    );
  }
  Widget dashboard (context) {
    return AnimatedPositioned(
      top: -45,
      bottom: -20,
      left: isCollapsed ? 0.0 : -0.50 * screenWidth!,
      right: isCollapsed ? 0.0 : 0.50 * screenWidth!,
      duration: duration,
      child: ScaleTransition(
        scale: _verySmallScaleAnimation,
        child: RefreshIndicator(
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          elevation: 8,
          color: Colors.grey[500],
          child: Container(
            color: Colors.grey[500],
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
          ),
        ),
          onRefresh: _loadResource,
        ),
      ),
    );
  }
  Widget dashboard2 (context) {
    return AnimatedPositioned(
      top: -35,
      bottom: -10,
      left: isCollapsed ? 0.0 : -0.60 * screenWidth!,
      right: isCollapsed ? 0.0 : 0.60 * screenWidth!,
      duration: duration,
      child: ScaleTransition(
        scale: _smallScaleAnimation,
        child: RefreshIndicator(
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            elevation: 8,
            color: Colors.grey[400],
            child: Container(
              color: Colors.grey[400],
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            ),
          ),
          onRefresh: _loadResource,
        ),
      ),
    );
  }
  Widget dashboard3 (context, BoxConstraints constraints) {

    List<int> list = [0, 1, 2, 3];
    list[0];

    return AnimatedPositioned(
      top: -20,
      bottom: 1,
      left: isCollapsed ? 0 : -0.7 * screenWidth!,
      right: isCollapsed ? 0 : 0.7 * screenWidth!,
      duration: duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: RefreshIndicator(
          child: Material(
            borderRadius: isCollapsed ? const BorderRadius.all(Radius.circular(0)) : const BorderRadius.all(Radius.circular(20)),
            elevation: 8,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45 / 0.7, bottom: Dimensions.height30 * 2),
              padding: EdgeInsets.only(left: Dimensions.width5 / 20, right: Dimensions.width5 / 20),
              //color: Colors.red,
              child: Stack(
                children: <Widget>[
                  //showing the header
                  AnimatedPositioned(
                    duration: panelTransition,
                    top: controller2.homeState == HomeState.normal
                        ? 0
                        : -headerHeight,
                    right: 5,
                    left: 5,
                    height: headerHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Center(
                        //   child: Container(
                        //     width: Dimensions.height45,
                        //     height: Dimensions.height45,
                        //     child: Lottie.asset('assets/search.json'),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(Dimensions.radius15),
                        //       color: Colors.white,
                        //     ),
                        //   ),
                          InkWell(
                            child: SizedBox(
                              height: Dimensions.height30 + 2,
                              width: Dimensions.width30 + 2,
                              child: Lottie.asset('assets/search.json'),
                            ),
                            onTap: () {
                              setState(() {
                                if(isCollapsed){
                                  _controller!.forward();
                                } else {
                                  _controller!.reverse();
                                }
                                isCollapsed = !isCollapsed;
                              },
                              );
                            },
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10,),
                            ElevatedButton(
                              onPressed: () {
                                Get.updateLocale( const Locale('en', 'US'),);
                              },
                              child: Text('button_1'.tr),
                            ),
                            const SizedBox(width: 2,),
                            ElevatedButton(
                              onPressed: () {
                                Get.updateLocale( const Locale('ar', 'EG'),);
                              },
                              child: Text('button_2'.tr),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20),
                        //   child: Column(
                        //     children: [
                        //       CustomBigText(
                        //         text: "Country",
                        //         color: primaryColor,
                        //       ),
                        //       Row(
                        //         children: const [
                        //           CustomSmallText(text: "City"),
                        //           Icon(Icons.arrow_drop_down),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        //const Icon(Icons.search_rounded, color: Colors.black87,),
                        //const Text(
                        //    "الصفحة الرئيسية", style: TextStyle(fontSize: 24, color: Colors.black87) ),
                        InkWell(
                          child: SizedBox(
                            height: Dimensions.height30 + 2,
                              width: Dimensions.width30 + 2,
                              child: Lottie.asset('assets/menu.json'),
                          ),
                          onTap: () {
                            setState(() {
                              if(isCollapsed){
                                _controller!.forward();
                              } else {
                                _controller!.reverse();
                              }
                              isCollapsed = !isCollapsed;
                            },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  //showing the body
                  AnimatedPositioned(
                    duration: panelTransition,
                    top: controller2.homeState == HomeState.normal
                        ? headerHeight / 1.1
                        : -(constraints.maxHeight - cartBarHeight * 2 - headerHeight),
                    right: 0,
                    left: 0,
                    height: constraints.maxHeight - headerHeight - cartBarHeight / 1.5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width5*0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          )
                      ),
                      height: Dimensions.height45 * 15,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: AdvertisementView(
                          // pageId: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onRefresh: _loadResource,
        ),
      ),
    );
  }
  Widget customcartview (context, BoxConstraints constraints, HomeController controller2){
    return AnimatedPositioned(
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
          padding: const EdgeInsets.all(0.01),
            child: controller2.homeState == HomeState.normal
                ? CardShortView(controller2: controller2)
                : const CartPage(),
        ),
      ),
    );
  }
}



