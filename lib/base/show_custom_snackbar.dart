import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';

void showCustomSnackBar(String message, {bool isError = true, String title = "Error",}){
  Get.snackbar(
    title,
    message,
    titleText: CustomBigText(text: title, color: Colors.white,),
    messageText: Text(message, style: const TextStyle(color: Colors.white),),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,
  );
}