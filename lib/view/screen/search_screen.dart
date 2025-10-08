import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/constant/app_color.dart';
import 'package:model_home_app/controller/product_category_model.dart';
import 'package:model_home_app/widgets/cards/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();

    final String? categoryId = Get.arguments; 

    if (categoryId != null) {
   
      productController.fetchProductsByCategory(categoryId);
    } else {
 
      productController.fetchAllProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: AppColor.textcolor,
            borderRadius: BorderRadius.circular(10),
          ),
        child: TextField(
  controller: _searchController,
  onChanged: (value) {
    productController.searchProducts(value); 
  },
  decoration: InputDecoration(
    hintText: "Search products",
    prefixIcon: const Icon(Icons.search),
    suffixIcon: IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        _searchController.clear();
        productController.searchProducts('');
      },
    ),
    border: InputBorder.none,
  ),
),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productController.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Found ${productController.products.length} products",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.titlecolor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

              
                GridView.builder(
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(), 
                  itemCount: productController.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return ProductCard(
                      title: product.title,
                      image: product.image,
                      price: product.price.toString(),
                      onTap: () {
                        Get.toNamed(
                          "/productscreen",
                          arguments: product.id,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
