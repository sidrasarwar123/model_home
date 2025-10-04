import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:model_home_app/constant/app_color.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
    body: Center(child:
     Text("Splash Screen",style: TextStyle(color: AppColor.buttoncolor,fontSize: 20,fontWeight: FontWeight.bold),),),
    );
  }
}