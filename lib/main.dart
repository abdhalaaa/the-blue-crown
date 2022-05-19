import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/category_list_view_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/grid_view_of_category_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/location_controller.dart';
import 'package:theblue_crown/pages/address/add_address_page.dart';
import 'package:theblue_crown/pages/home/details_view2.dart';
import 'package:theblue_crown/pages/home/details_view3.dart';
import 'package:theblue_crown/pages/home/home_view.dart';
import 'dart:async';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/translation.dart';
import 'controllers/controller_lists/el_momtaz_labsa_controller.dart';
import 'controllers/controller_lists/super_el_momtaz_labsa_controller.dart';
import 'controllers/controller_lists/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {  
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController(locationRepo: Get.find()));
    Get.find<CartController>().getCartData();
    Get.find<GridViewOfCategoryController>().getGridViewOfCategoryList();
    Get.find<CategoryListViewController>().getCategoryListViewList();
    Get.find<ElMomtazLabsaController>().getElMomtazLabsaList();
    Get.find<SuperElMomtazLabsaController>().getSuperElMomtazLabsaList();
    return GetBuilder<PopularProductController>(builder: (_){
      // return GetBuilder<PopularProductController2>(builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'US'),
            translations: Translation(),
            //home: SplashScreen(),
            //home:SignInPage(),
            //home: HomeScreen(),
            // home: DetailsView3(),
            //home: ProductScreen(),
            //home: AddAddressPage(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
          },);
        // },);
      },);
  }
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Maps Sample App'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
// }