import 'package:get/get.dart';
import 'package:theblue_crown/pages/address/add_address_page.dart';
import 'package:theblue_crown/pages/auth/sign_in_page.dart';
import 'package:theblue_crown/pages/cart/cart_page.dart';
import 'package:theblue_crown/pages/home/details_view.dart';
import 'package:theblue_crown/pages/home/home_view.dart';
import 'package:theblue_crown/pages/home/recommended_details.dart';
import 'package:theblue_crown/pages/splash/splash_page.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/home/company_or_factory_file/company_or_factory_view.dart';
import '../pages/home/details_view3.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String companyOrFactoryView = "/company-or-factory-view";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String gridViewOfCategoryFood = "/grid-view-of-category-food";
  static const String categoryListViewFood = "/category-list-view-food";
  static const String elMomtazLabsaFood = "/el-momtaz-labsa-food";
  static const String superElMomtazLabsaFood = "/super-el-momtaz-labsa";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getCompanyOrFactoryView() => '$companyOrFactoryView';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getGridViewOfCategoryFood(int pageId, String page) => '$gridViewOfCategoryFood?pageId=$pageId&page=$page';
  static String getCategoryListViewFood(int pageId, String page) => '$categoryListViewFood?pageId=$pageId&page=$page';
  static String getElMomtazLabsaFood(int pageId, String page) => '$elMomtazLabsaFood?pageId=$pageId&page=$page';
  static String getSuperElMomtazLabsaFood(int pageId, String page) => '$superElMomtazLabsaFood?pageId=$pageId&page=$page';
  static String getCartPage () => '$cartPage';
  static String getSignInPage () => '$signIn';
  static String getAddAddressPage () => '$addAddress';
  static String getPickAddressPage () => '$pickAddressMap';

  static List<GetPage> routes = [
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddress = Get.arguments;
        print("going to a new page");
        return _pickAddress;
      },
    ),
    GetPage(
        name: splashPage,
        page: () => const SplashScreen(),
    ),
    GetPage(
      name: initial,
      page: (){
        return const HomeView();
        },
        transition: Transition.fadeIn
      ),
    GetPage(
        name: companyOrFactoryView,
        page: (){
          return const CompanyOrFactoryView();
        },
        transition: Transition.fadeIn
    ),

    GetPage(
      name: signIn,
      page: (){return const SignInPage();},
      transition: Transition.fade,
    ),

    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return DetailsView(pageId : int.parse(pageId!), page: page!);
        // return ProductScreen(pageId : int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn
    ),
    GetPage(
        name: superElMomtazLabsaFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return DetailsView(pageId : int.parse(pageId!), page: page!);
          // return ProductScreen(pageId : int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: elMomtazLabsaFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return DetailsView(pageId : int.parse(pageId!), page: page!);
          // return ProductScreen(pageId : int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedDetails(pageId : int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: gridViewOfCategoryFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedDetails(pageId : int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: categoryListViewFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedDetails(pageId : int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: cartPage,
        page: () {return const CartPage();},
        transition: Transition.fadeIn
    ),
    GetPage(name: addAddress, page: () {
      return AddAddressPage();
      },
    ),
  ];
}