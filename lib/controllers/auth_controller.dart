import 'dart:convert';

import 'package:get/get.dart';
import 'package:theblue_crown/data/repository/auth_repo.dart';
import 'package:theblue_crown/models/response_model.dart';
import 'package:theblue_crown/models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {

  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody)async{
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      print("My token is " + response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password)async{
    // print("Getting token");
    // print(jsonEncode(authRepo.getUserToken().toString()));
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      // print("Backend token");
      authRepo.saveUserToken(response.body["token"]);
      print("My token is  " + response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  saveUserNumberAndPassword(String number, String password){
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

}
