import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:theblue_crown/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/controllers/location_controller.dart';
import 'package:theblue_crown/controllers/user_controller.dart';
import 'package:theblue_crown/models/address_model.dart';
import 'package:theblue_crown/pages/address/pick_address_map.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/app_text_field.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =  CameraPosition(target: LatLng(
    45.51563, -122.677433
  ), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433,);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel == null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage() == ""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]),
          ),
      );
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouteHelper.getInitial());
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Address page".tr),
            backgroundColor: Colors.blue,
          ),
          body: GetBuilder<UserController>(builder: (userController){
            if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
              _contactPersonName.text = '${userController.userModel?.name}';
              _contactPersonNumber.text = '${userController.userModel?.phone}';
              if(Get.find<LocationController>().addressList.isNotEmpty){
               _addressController.text = Get.find<LocationController>().getUserAddress().address;
              }
            }
            return GetBuilder<LocationController>(builder: (locationController) {
              _addressController.text =
                  '${locationController.placeMark.name??''}'
                  '${locationController.placeMark.locality??''}'
                  '${locationController.placeMark.postalCode??''}'
                  '${locationController.placeMark.country??''}';
              print("address in my view is " + _addressController.text);
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.height45 * 4,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(Dimensions.height10 / 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(initialCameraPosition:
                          CameraPosition(
                              target: _initialPosition,
                              zoom: 17
                          ),
                            onTap: (latlng){
                            Get.toNamed(
                                RouteHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromSignup: false,
                                  fromAddress: true,
                                  // canRoute: false,
                                  // route: "",
                                  googleMapController: locationController.mapController,
                                ),
                            );
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: (){  locationController.updatePosition(_cameraPosition, true); },
                            onCameraMove: ((position) => _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller){
                              locationController.setMapController(controller);
                              if(Get.find<LocationController>().addressList.isEmpty){
                                // locationController.getCurrentLocation(true, mapController: controller);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        top: Dimensions.height20
                      ),
                      child: SizedBox(
                        height: Dimensions.height45,
                        child: ListView.builder(
                          shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locationController.addressTypeList.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){  locationController.setAddressTypeIndex(index);  },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20,
                                      vertical: Dimensions.height10,
                                  ),
                                  margin: EdgeInsets.only(right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      ),
                                    ]
                                  ),
                                  child: Icon(
                                    index == 0 ?
                                    Icons.home_filled :
                                       index == 1 ?
                                           Icons.work :
                                           Icons.location_on,
                                    color: locationController.addressTypeIndex == index ?
                                    Colors.blue :
                                    Theme.of(context).disabledColor,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                      child: CustomBigText(text: "Delivery address".tr,),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    AppTextField(
                      textController: _addressController,
                      hintText: "Your Address".tr,
                      icon: Icons.map,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20, top: Dimensions.height10),
                      child: CustomBigText(text: "Contact Name".tr,),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    AppTextField(
                      textController: _contactPersonName,
                      hintText: "Your Name",
                      icon: Icons.person,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20, top: Dimensions.height10),
                      child: CustomBigText(text: "Your Number".tr,),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    AppTextField(
                      textController: _contactPersonNumber,
                      hintText: "Your Number".tr,
                      icon: Icons.phone,
                    ),
                  ],
                ),
              );
            }
            );
          }),
          bottomNavigationBar: GetBuilder<LocationController>(
            builder: (locationController){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Dimensions.height20 * 7,
                    padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20,),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            AddressModel _addressModel = AddressModel(
                                addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                              contactPersonName: _contactPersonName.text,
                              contactPersonNumber: _contactPersonNumber.text,
                              address: _addressController.text,
                              latitude: locationController.position.latitude.toString(),
                              longitude: locationController.position.longitude.toString(),
                            );
                            locationController.addAddress(_addressModel).then((response){
                              if(response.isSuccess){
                                Get.toNamed(RouteHelper.getInitial());
                                Get.snackbar("Address", "Added Successfully");
                              }else{
                                Get.snackbar("Address", "Couldn't save address");
                              }
                            });
                          },
                          child: Container (
                            padding: EdgeInsets.only(top: Dimensions.height45 / 2, bottom: Dimensions.height45 / 2, left: Dimensions.width20, right: Dimensions.width20,),
                            child: CustomBigText(
                              text: "Save address".tr,
                              size: 26,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
