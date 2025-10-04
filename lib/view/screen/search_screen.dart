import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:model_home_app/constant/app_color.dart';
import 'package:model_home_app/constant/app_image.dart';
import 'package:model_home_app/widgets/cards/category_card.dart';
import 'package:model_home_app/widgets/cards/product_card.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search products",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear(); // clear text
                },
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
               Text("Found 50 results",
                  style: TextStyle(fontSize: 15, color: AppColor.titlecolor)),
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
                        Get.toNamed("/productscreen");
                      },
                    ),
                    CategoryCard(
                      title: "Wood chair",
                      image: AppImage.chair8,
                      productsCount: "15+ Product",
                      onTap: () {
                         Get.toNamed("/productscreen"); 
                      },
                    ),
                  ],
                ),
              ),
              
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
                          SizedBox(height: screenHeight*0.02),
              SizedBox(
                height:screenHeight*0.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductCard(
                      title: "Wood Frame",
                      image: AppImage.chair7,
                      price: "120",
                      onTap: () {
                       Get.toNamed("/productscreen");
                      },
                    ),
                    ProductCard(
                      title: "Yellow Armchair",
                      image: AppImage.chair10,
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