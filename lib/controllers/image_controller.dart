import 'dart:convert';
import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController{

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
  String? _imagePath;
  String? get imagePath => _imagePath;

  // Implementing the image picker
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  Future<bool> upload() async {

    update();
    bool success = false;

    http.StreamedResponse response = await updateProfile(_pickedFile);
    // _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      _imagePath=message;
      // _pickedFile = null;
      //await getUserInfo();
      success = true;
      print(message = "****************************************  server works  ****************************************");
    } else {
      print("error uploading the image");
    }

    update();
    return success;
  }

  Future<http.StreamedResponse> updateProfile(PickedFile? data) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(
        // 'http://127.0.0.1:8000/upload'
        // 'http://10.0.2.2:8000/upload'
        'http://mvs.bslmeiyu.com/api/v1/auth/upload'
    ));
    // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if(GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
    }
    // Map<String, String> _fields = Map();
    // _fields.addAll(<String, String>{
    //   'f_name': userInfoModel.fName,  'email': userInfoModel.email
    // });
    // request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

}