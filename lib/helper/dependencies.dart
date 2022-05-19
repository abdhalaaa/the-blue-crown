import 'package:shared_preferences/shared_preferences.dart';
import 'package:theblue_crown/controllers/auth_controller.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/category_list_view_controller.dart';
import 'package:theblue_crown/controllers/image_controller.dart';
import 'package:theblue_crown/controllers/location_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/popular_product_controller.dart';
import 'package:theblue_crown/controllers/controller_lists/recommended_product_controller.dart';
import 'package:theblue_crown/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/data/repository/auth_repo.dart';
import 'package:theblue_crown/data/repository/cart_repo.dart';
import 'package:theblue_crown/data/repository/location_repo.dart';
import 'package:theblue_crown/data/repository/repo_lists/category_list_view_repo.dart';
import 'package:theblue_crown/data/repository/repo_lists/recommended_product_repo.dart';
import 'package:theblue_crown/data/repository/user_repo.dart';
import 'package:theblue_crown/utils/app_constants.dart';
import '../controllers/controller_lists/el_momtaz_labsa_controller.dart';
import '../controllers/controller_lists/grid_view_of_category_controller.dart';
import '../controllers/controller_lists/super_el_momtaz_labsa_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/repo_lists/el_momtaz_labsa_repo.dart';
import '../data/repository/repo_lists/grid_view_of_category_repo.dart';
import '../data/repository/repo_lists/popular_product_repo.dart';
import '../data/repository/repo_lists/super_el_momtaz_labsa_repo.dart';

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=>UserRepo(apiClient: Get.find()));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => GridViewOfCategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryListViewRepo(apiClient: Get.find()));
  Get.lazyPut(() => ElMomtazLabsaRepo(apiClient: Get.find()));
  Get.lazyPut(() => SuperElMomtazLabsaRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => GridViewOfCategoryController(gridViewOfCategoryRepo: Get.find()));
  Get.lazyPut(() => CategoryListViewController(categoryListViewRepo: Get.find()));
  Get.lazyPut(() => ElMomtazLabsaController(elMomtazLabsaRepo: Get.find()));
  Get.lazyPut(() => SuperElMomtazLabsaController(superElMomtazLabsaRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()),);
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => ImageController());
}