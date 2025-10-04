import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:model_home_app/constant/app_color.dart';
import 'package:model_home_app/constant/app_image.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppImage.onbording1,
      "title": "We provide high quality products just for you",
      "button": "Next",
    },
    {
      "image": AppImage.onbording2,
      "title": "Your satisfaction is our number one priority",
      "button": "Next",
    },
    {
      "image": AppImage.onbording3,
      "title": "Let’s fulfil your daily needs with us",
      "button": "Get Started",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.40, 
                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            item["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.04),

                     
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: onboardingData.length,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey,
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 6,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.05),

                     
                        ElevatedButton(
                          onPressed: () {
                            if (index < onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            } else {
                            Get.offAllNamed("/welcomescreen");
                          
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttoncolor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            item["button"]!,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.textcolor,
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
