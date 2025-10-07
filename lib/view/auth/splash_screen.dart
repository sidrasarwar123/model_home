import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:model_home_app/constant/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  void checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay

    final isFirstTime = box.read("isFirstTime") ?? true;
    final user = FirebaseAuth.instance.currentUser;

    if (isFirstTime) {
      box.write("isFirstTime", false); // ek dafa onboarding dikhani ha
      Get.offAllNamed('/onboarding');
      return;
    }

    if (user == null) {
      // agar user login nahi ha
      Get.offAllNamed('/welcomescreen');
    } else {
      // agar user login ha to home screen par bhej do
      Get.offAllNamed('/bottombar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(
            color: AppColor.buttoncolor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
