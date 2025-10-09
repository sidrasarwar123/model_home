import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/controller/home_controller.dart';

import '../../widgets/cards/category_card.dart';
import '../../widgets/cards/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {

        }, icon: const Icon(Icons.menu)),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text("Scan"),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          else if( controller.categories.isEmpty){
   return Center(child:Text("No Category found") );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Browse by Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  height: screenHeight * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return CategoryCard(
                        title: category.title,
                        image: category.image,
                        productsCount: category.productsCount,
                        onTap: () {
                            print("Selected category ID: ${category.id}");
                          Get.toNamed("/search",
                              arguments: category.id);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                const Text(
                  "Recommended for You",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              
               SizedBox(
  height: screenHeight * 0.3,
  child: Obx(() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.products.length,
      itemBuilder: (context, index) {
        final product = controller.products[index];
        return ProductCard(
          title: product.title,
          image: product.image,
          price: product.price.toString(),
          onTap: () {
            Get.toNamed(
              "/productscreen",
              arguments: {
                'title': product.title,
                'category': product.category,
                'price': product.price,
                'description': product.description,
                'colors': product.colors,
                'image': product.image,
              },
            );
          },
        );
      },
    );
  }),
),

              ],
            ),
          );
        }),
      ),
    );
  }
}
