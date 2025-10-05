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
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      final box = GetStorage();

      // 👇 add default value if null
      final isOnboardingPlayed = box.read('isOnboardingPlayed') ?? false;

      User? user = FirebaseAuth.instance.currentUser;

      if (!isOnboardingPlayed) {
        Get.offAllNamed('/onboarding');
      } else if (user != null) {
        Get.offAllNamed("/bottombar");
      } else {
        Get.offAllNamed('/welcomescreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(
            color: AppColor.buttoncolor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
