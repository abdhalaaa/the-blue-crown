import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/base/custom_loader.dart';
import 'package:theblue_crown/base/show_custom_snackbar.dart';
import 'package:theblue_crown/controllers/auth_controller.dart';
import 'package:theblue_crown/pages/auth/sign_up_page.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/app_text_field.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    // var nameController = TextEditingController();
    // var phoneController = TextEditingController();
    void _login(AuthController authController){
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Type in your email address".tr, title: "Email address".tr);
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password".tr, title: "Password".tr);
      }else if(password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters".tr, title: "Password".tr);
      }else {
        authController.login(phone, password).then((status){
          if(status.isSuccess){
            //print("Success registration");
            Get.toNamed(RouteHelper.getInitial());
            //Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }



    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading ?
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight * 0.05,),
                //app logo
                SizedBox(
                  height: Dimensions.screenHeight * 0.25,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                          "assets/images/splash.png"
                      ),
                    ),
                  ),
                ),

                //welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello".tr,
                        style: TextStyle(
                          fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sign into your account".tr,
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),

                //your email
                AppTextField(
                  textController: phoneController,
                  hintText: "Phone".tr,
                  icon: Icons.phone,
                ),
                SizedBox(height: Dimensions.height20,),

                //your password
                AppTextField(
                  textController: passwordController,
                  hintText: "Password".tr,
                  icon: Icons.password_sharp,
                  isObscure: true,
                ),

                SizedBox(height: Dimensions.height20,),
                //tag line
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                      text: TextSpan(
                        text: "Sing into your account".tr,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width20,),
                  ],
                ),

                SizedBox(height: Dimensions.screenHeight * 0.05,),

                //sign in button
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth / 2,
                    height: Dimensions.screenHeight / 13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.blueAccent
                    ),
                    child: Center(
                      child: CustomBigText(
                        text: "Sign in".tr,
                        size: Dimensions.font20 + Dimensions.font20 / 2,
                        // alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight * 0.05,),
                //sign up options
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ".tr,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
                        text: "Create".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) :
          const CustomLoader();
        })
      ),
    );
  }
}
