import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/base/custom_button.dart';
import 'package:theblue_crown/controllers/location_controller.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';

import 'widgets/location_search_dialogue.dart';

class PickAddressMap extends StatefulWidget {

  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {

  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return WillPopScope(
        onWillPop: () async {
          Get.toNamed(RouteHelper.getAddAddressPage());
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition){_cameraPosition = cameraPosition;},
                      onCameraIdle: (){Get.find<LocationController>().updatePosition(_cameraPosition, false);},
                      onMapCreated: (GoogleMapController mapController) {
                        _mapController = mapController;
                        locationController.setMapController(mapController);
                      },
                    ),
                    Center(
                      child: !locationController.loading
                          // ? Image.asset("assets/images/google-map-maker3.png", height: 50, width: 50,)
                          ? const Icon(Icons.location_on, size: 50, color: Colors.blue,)
                          : const CircularProgressIndicator()
                    ),

                    // showing and selecting address
                    Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap:() => Get.dialog(LocationDialogue(mapController: _mapController)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                          height: Dimensions.height45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, size: 25, color: Colors.white,),
                              Expanded(
                                child: Text(
                                      '${locationController.pickPlaceMark.name??''}'
                                      '${locationController.pickPlaceMark.locality ?? ''} '
                                      '${locationController.pickPlaceMark.postalCode ?? ''} '
                                      '${locationController.pickPlaceMark.country ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10),
                              const Icon(
                                Icons.search,
                                size: 25,
                                // color: Theme.of(context).textTheme.bodyText1!.color),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Dimensions.height45 * 2,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: locationController.isLoading ?
                        const Center(child: CircularProgressIndicator()) :
                        CustomButton(
                          buttonText: locationController.inZone ?
                          widget.fromAddress ? 'Pick Address'.tr : 'Pick Location'.tr :
                          'Service is not available in your area'.tr,

                          onPressed: (locationController.buttonDisabled || locationController.loading) ?
                              null :
                              (){if(locationController.pickPosition.latitude!=0&&locationController.pickPlaceMark.name!=null){
                                if(widget.fromAddress){
                                  if(widget.googleMapController!=null){
                                    print("Now you can clicked on this");
                                    widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                      locationController.pickPosition.latitude,
                                      locationController.pickPosition.longitude,
                                    ))));
                                    locationController.setAddAddressData();
                                  }
                                  // Get.back() creates update problem
                                  // list, a value
                                  Get.toNamed(RouteHelper.getAddAddressPage());
                                }
                              }
                              },
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}
