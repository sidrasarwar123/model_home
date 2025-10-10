
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:model_home_app/controller/product_category_model.dart';
import 'package:model_home_app/firebase_options.dart';
import 'package:model_home_app/routes/app_routes.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
     await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  final box = GetStorage();
  final isOnboardingPlayed = box.read('isOnboardingPlayed');

  if (isOnboardingPlayed == null) {
    box.write('isOnboardingPlayed', false);
  }
    Get.put(ProductController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/splashscreen',
          getPages: AppRoutes.routes,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
