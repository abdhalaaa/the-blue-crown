import 'package:get/get.dart';
import 'package:theblue_crown/data/api/api_client.dart';
import 'package:theblue_crown/utils/app_constants.dart';

class ElMomtazLabsaRepo extends GetxService{
  final ApiClient apiClient;


  ElMomtazLabsaRepo({required this.apiClient});

  Future<Response> getElMomtazLabsaList() async {
    return await apiClient.getData(AppConstants.EL_MOMTAZ_LABSA_URI);
  }
}