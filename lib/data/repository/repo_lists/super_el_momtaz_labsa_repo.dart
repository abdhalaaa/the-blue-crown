import 'package:get/get.dart';
import 'package:theblue_crown/data/api/api_client.dart';
import 'package:theblue_crown/utils/app_constants.dart';

class SuperElMomtazLabsaRepo extends GetxService{
  final ApiClient apiClient;


  SuperElMomtazLabsaRepo({required this.apiClient});

  Future<Response> getSuperElMomtazLabsaList() async {
    return await apiClient.getData(AppConstants.SUPER_EL_MOMTAZ_LABSA_URI);
  }
}