import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/base/custom_loader.dart';
import 'package:theblue_crown/base/show_custom_snackbar.dart';
import 'package:theblue_crown/controllers/auth_controller.dart';
import 'package:theblue_crown/models/signup_body_model.dart';
import 'package:theblue_crown/routes/route_helper.dart';
import 'package:theblue_crown/utils/dimensions.dart';
import 'package:theblue_crown/widgets/app_text_field.dart';
import 'package:theblue_crown/widgets/custom_big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var singUpImages = [
      "twitter.png",
      "facebook.png",
      "google.png",
    ];

    void _registration(AuthController authController){
      //var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name".tr, title: "Name".tr);
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number".tr, title: "Phone number".tr);
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address".tr, title: "Email address".tr);
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address".tr, title: "Valid email address".tr);
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password".tr, title: "Password".tr);
      }else if(password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters".tr, title: "Password".tr);
      }else {
        //showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password,);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration".tr);
            Get.offNamed(RouteHelper.getInitial());
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
        body: GetBuilder<AuthController>(builder: (_authController){
          return !_authController.isLoading ?
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

                //your email
                AppTextField(
                  textController: emailController,
                  hintText: "Email".tr,
                  icon: Icons.email,
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

                //your name
                AppTextField(
                  textController: nameController,
                  hintText: "Name".tr,
                  icon: Icons.person,
                ),
                SizedBox(height: Dimensions.height20,),

                //your phone
                AppTextField(
                  textController: phoneController,
                  hintText: "Phone".tr,
                  icon: Icons.phone,
                ),
                SizedBox(height: Dimensions.height20 + Dimensions.height20,),
                //sign up button
                GestureDetector(
                  onTap: (){
                    _registration(_authController);
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
                        text: "Sign up".tr,
                        size: Dimensions.font20 + Dimensions.font20 / 2,
                        // alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.height10,),
                //tag line
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Have an account already ?".tr,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.height20,),
                //sign up options
                RichText(
                  text: TextSpan(
                    text: "Sign up using one of the following methods".tr,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    ),
                  ),
                ),
                Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                        "assets/images/" + singUpImages[index],
                      ),
                    ),
                  )),
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
