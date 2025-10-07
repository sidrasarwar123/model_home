import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/constant/app_color.dart';


import 'package:model_home_app/constant/app_image.dart';
import 'package:model_home_app/controller/auth_controller.dart';
import 'package:model_home_app/widgets/button/custom_button.dart';
import 'package:model_home_app/widgets/button/social_button.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
    bool isLoading = false;
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Center(
                child: Image.asset(
                  AppImage.login,
                 height: screenHeight*0.3,
                ),
              ),
              const SizedBox(height: 20),

              
              const Text(
                "Let’s You in",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: screenHeight*0.03),

           Column(
  children: [
    SocialButton(
      icon: Icons.facebook,
      text: "Continue with Facebook",
      color: AppColor.textcolor,
      textColor: Colors.black,
      iconColor: Colors.blue, 
    ),
     SizedBox(height: screenHeight*0.02),
SocialButton(
  icon: Icons.g_mobiledata,
  text: "Continue with Google",
  color: AppColor.textcolor,
  textColor: Colors.black,
  iconColor: Colors.red,
   onPressed: () => authController.signInWithGoogle(),
),
       SizedBox(height: screenHeight*0.02),
  SocialButton(
  icon: Icons.apple,
  text: "Continue with Apple",
  color: AppColor.textcolor,
  textColor: Colors.black,
  iconColor: Colors.black,
 onPressed: () => authController.signInWithApple(),
),
           
  ],
),

    SizedBox(height: screenHeight*0.03),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
            SizedBox(height: screenHeight*0.03),
              CustomButton(text: "Sign in with Password",
               isloading: isLoading,
          onPressed: () async {
            setState(() => isLoading = true);
            await Future.delayed(const Duration(seconds: 2));
          setState(() => isLoading = false);
            Get.toNamed("/login");
          },
              ),

               SizedBox(height: screenHeight*0.03),

              // Bottom text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have account? "),
                  GestureDetector(
                    onTap: () {
                    Get.toNamed("/signup");
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}