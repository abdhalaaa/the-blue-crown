import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';
import '../../routes/route_helper.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: () async {
      //   Get.toNamed(RouteHelper.getInitial());
      //   return true;
      // },
      // child:
      Scaffold(
        appBar: AppBar(
          title: CustomBigText(
            text: "Settings".tr,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  itemCount: 8,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 0,);
                  },
                  itemBuilder: (context, index){
                    return Container(height: 150, width: 150,color: Colors.red,);
                  },
                ),
              ),
              const SizedBox(height: 200,),
              ElevatedButton(
                onPressed: () {
                  Get.updateLocale(const Locale('en', 'US'),);
                },
                child: Text('button_1'.tr),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Get.updateLocale(const Locale('ar', 'EG'),);
                },
                child: Text('button_2'.tr),
              ),
            ],
          ),
        ),
      );
    // );
  }
}




