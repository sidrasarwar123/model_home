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

  // 3 second ke liye splash screen dikhao
  Timer(const Duration(seconds: 3), () {
    final box = GetStorage();  // local storage ka instance

    // Check karo ke user ne onboarding complete kiya ya nahi
    final isOnboardingPlayed = box.read('isOnboardingPlayed') ?? false;

    // FirebaseAuth se current user check karo
    User? user = FirebaseAuth.instance.currentUser;

    if (!isOnboardingPlayed) {
      // Agar first time hai → Onboarding dikhao
      Get.offAllNamed('/onboarding');
    } else if (user != null) {
      // Agar onboarding complete ho chuki aur user login hai → Home dikhao
      Get.offAllNamed("/bottombar");
    } else {
      // Agar onboarding complete ho chuki lekin user login nahi hai → Welcome/Login dikhao
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
