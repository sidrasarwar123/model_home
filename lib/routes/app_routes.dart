
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:model_home_app/view/auth/login_screen.dart';
import 'package:model_home_app/view/auth/welcome_screen.dart';
import 'package:model_home_app/view/auth/onbording_screen.dart';
import 'package:model_home_app/view/auth/signup_screen.dart';
import 'package:model_home_app/view/auth/splash_screen.dart';
import 'package:model_home_app/view/screen/checkout_screen.dart';
import 'package:model_home_app/view/screen/order_review.dart';

import 'package:model_home_app/view/screen/search_screen.dart';
import 'package:model_home_app/view/screen/single_product_screen.dart';

import 'package:model_home_app/widgets/bottom_bar_screen.dart';



class AppRoutes {
   static final routes=[
      GetPage(name: '/splashscreen', page: ()=>SplashScreen()),
        GetPage(name: '/onboarding', page: ()=>OnboardingScreen()),
         GetPage(name: '/welcomescreen', page: ()=>WelcomeScreen()),
          GetPage(name: '/signup', page: ()=>SignupScreen()),
      GetPage(name: '/login', page: ()=>LoginScreen()),
    GetPage(name: '/bottombar', page: ()=>BottombarScreen()),
    GetPage(name: '/search', page: ()=>SearchScreen()),
    GetPage(name: '/productscreen',page: () => ProductDetailScreen()),
      GetPage(name: '/cartscreen',page: () =>OrderReviewPage()),
        GetPage(name: '/checkout',page: () =>CheckoutScreen()),
  
   ];
}