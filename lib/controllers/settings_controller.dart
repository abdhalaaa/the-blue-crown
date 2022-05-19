// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// // class SettingsController extends GetxController {
// //   late ThemeData themeData;
// //   final box = GetStorage();
// //   @override // called when you use Get.put before running app
// //   void onInit() {
// //     super.onInit();
// //     _restoreTheme();
// //   }
// //   void _restoreTheme() {
// //     bool isDark = box.read('isDark') ?? true; // null check for first time running this
// //     if (isDark) {
// //       themeData = ThemeData.dark();
// //     } else {
// //       themeData = ThemeData.light();
// //     }
// //   }
// //   void storeThemeSetting(bool isDark) {
// //     box.write('isDark', isDark);
// //   }
// // }
// class SettingsController extends GetxController {
//   late LanguageChanging languageChanging;
//   final box = GetStorage();
//   @override // called when you use Get.put before running app
//   void onInit() {
//     super.onInit();
//     _restoreTheme();
//   }
//   void _restoreTheme() {
//     bool isDark = box.read('isDark') ?? true; // null check for first time running this
//     if (isDark) {
//       themeData = ThemeData.dark();
//     } else {
//       themeData = ThemeData.light();
//     }
//   }
//   void storeThemeSetting(bool isDark) {
//     box.write('isDark', isDark);
//   }
// }