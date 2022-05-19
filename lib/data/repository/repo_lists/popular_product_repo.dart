import 'package:get/get.dart';
import 'package:theblue_crown/data/api/api_client.dart';
import 'package:theblue_crown/utils/app_constants.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;


  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    // return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI2);
    // return await apiClient.getData(AppConstants.CHEMICALS_URI);
  }
}