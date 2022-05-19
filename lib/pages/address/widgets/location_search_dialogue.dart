import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import '../../../controllers/location_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {

  const LocationDialogue({required this.mapController});

  final GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {

    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top : Dimensions.height45 * Dimensions.height10 / 14),
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius20 / 2)),
        child: SizedBox(
            width: Dimensions.screenWidth,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: 'search location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                    fontSize: Dimensions.font16, color: Theme.of(context).disabledColor,
                  ),
                  filled: true, fillColor: Theme.of(context).cardColor,
                ),
                style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: Theme.of(context).textTheme.bodyText1?.color, fontSize: Dimensions.font16,
                ),
              ),


              onSuggestionSelected: (Prediction suggestion) {
                print("My location is " + suggestion.description!);
                Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                Get.back();
              },

              //as we type, it gives us suggestion
              suggestionsCallback: (pattern) async {
                return await Get.find<LocationController>().searchLocation(context, pattern);
              },


              itemBuilder: (BuildContext context, Prediction suggestion) {
                return Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: Row(children: [
                    const Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                          suggestion.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline2?.copyWith(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: Dimensions.font16,
                          ),
                      ),
                    ),
                  ],
                  ),
                );
              },
            ),
        ),
      ),
    );
  }
}