import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';


import 'package:model_home_app/constant/app_image.dart';
import 'package:model_home_app/widgets/button/custom_button.dart';
import 'package:model_home_app/widgets/fields/custom_textfield.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
    bool rememberMe = false; 
  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: SafeArea(
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
                  "Create your account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(height: screenHeight*0.03),
          
             Column(
            children: [
              CustomTextField(hintText: "Email",prefixIcon: Icons.mail,),
              CustomTextField(hintText: "Password",prefixIcon: Icons.lock,isPassword: true,),
             
            Padding(
              padding:  EdgeInsets.only(left: screenWidth*0.2),
              child: Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
              setState(() {
                rememberMe = value!; // toggle value
              });
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  ),
            ),
      
            CustomButton(text: "Sign Up", onPressed: (){
             Get.toNamed("/bottombar");
                }),
             ],
          ),
          
              SizedBox(height: screenHeight*0.03),
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or continue with"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
              SizedBox(height: screenHeight*0.03),
                     
                Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => print("Apple Login"),
          child: const Icon(Icons.apple, size: 30, color: Colors.black),
        ),
        const SizedBox(width: 12),

        // Google Button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => print("Google Login"),
          child: const Icon(Icons.g_mobiledata, size: 30, color: Colors.red),
        ),
        const SizedBox(width: 12),

        // Facebook Button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => print("Facebook Login"),
          child: const Icon(Icons.facebook, size: 30, color: Colors.blue),
        ),
      ],
    ),
            
       
          
                 SizedBox(height: screenHeight*0.02),
          
                // Bottom text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account "),
                    GestureDetector(
                      onTap: () {
                       Get.toNamed("/login");
                      },
                      child: const Text(
                        "Sign in",
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
        ),
    );
  }
}
 