import 'package:get/get.dart';
import 'package:theblue_crown/data/api/api_client.dart';
import 'package:theblue_crown/utils/app_constants.dart';

class CategoryListViewRepo extends GetxService{
  final ApiClient apiClient;


  CategoryListViewRepo({required this.apiClient});

  Future<Response> getCategoryListViewList() async {
    return await apiClient.getData(AppConstants.CATEGORYListVIEW_URI);
  }
}