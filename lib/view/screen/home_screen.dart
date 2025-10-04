import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/constant/app_image.dart';
import 'package:model_home_app/widgets/cards/category_card.dart';
import 'package:model_home_app/widgets/cards/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final screenHeight = MediaQuery.of(context).size.height;
       
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)
        ),
        actions: [
          TextButton.icon(onPressed: (){},icon: Icon(Icons.qr_code_scanner), label:Text("Scan") )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              const Text("Browse by Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               SizedBox(height:screenHeight*0.03 ),
              SizedBox(
                height:screenHeight*0.3 ,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCard(
                      title: "Armchair",
                      image: AppImage.chair1,
                      productsCount: "100+ Product",
                      onTap: () {
                        Get.toNamed("/search");
                      },
                    ),
                    CategoryCard(
                      title: "Sofa",
                      image: AppImage.sofa4,
                      productsCount: "15+ Product",
                      onTap: () {
                            Get.toNamed("/search");
                      },
                    ),
                  ],
                ),
              ),
               SizedBox(height: screenHeight*0.04),

              const Text("Recommended for You",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight*0.02),
              SizedBox(
                height:screenHeight*0.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductCard(
                      title: "Wood Frame",
                      image: AppImage.chair3,
                      price: "120",
                      onTap: () {
                             Get.toNamed("/productscreen");
                      },
                    ),
                    ProductCard(
                      title: "Yellow Armchair",
                      image: AppImage.chair5,
                      price: "150",
                      onTap: () {
                            Get.toNamed("/productscreen");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}