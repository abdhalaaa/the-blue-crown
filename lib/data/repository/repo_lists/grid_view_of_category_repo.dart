import 'package:get/get.dart';
import 'package:theblue_crown/data/api/api_client.dart';
import 'package:theblue_crown/utils/app_constants.dart';

class GridViewOfCategoryRepo extends GetxService{
  final ApiClient apiClient;


  GridViewOfCategoryRepo({required this.apiClient});

  Future<Response> getGridViewOfCategoryList() async {
    return await apiClient.getData(AppConstants.GRIDVIEWOFGATEGORY_URI);
  }
}