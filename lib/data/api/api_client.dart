import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theblue_crown/utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({
    required this.appBaseUrl, required this.sharedPreferences,
   }){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
      'Connection' : 'Keep-Alive',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
      'Connection' : 'Keep-Alive',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers})async{
    try{
      Response response = await get(
        uri,
        // contentType: contentType,
        // query: query,
        headers: headers ?? _mainHeaders,
        // headers: {
        //   'Content-type' : 'application/json; charset=UTF-8',
        //   'Authorization' : 'Bearer $token',
        // },
        // decoder: decoder,
      );
      print(response.body.toString());
      // response = handleResponse(response);
      return response;
    }catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print(body.toString());
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      // response = handleResponse(response);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}