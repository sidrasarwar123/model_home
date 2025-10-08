import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/Models/product_model.dart';

import 'package:model_home_app/constant/app_color.dart';

import 'package:model_home_app/widgets/button/custom_button.dart';

import '../../../widgets/color_option.dart';


class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
   late ProductModel product;
  int selectedColorIndex = 0;

   @override
  void initState() {
    super.initState();

    // Get.arguments is Map<String, dynamic>
    final args = Get.arguments as Map<String, dynamic>;

    product = ProductModel(
    id: args['id'] ?? '',
    title: args['title'] ?? 'No title',
    category: args['category'] ?? 'No category',
    price: (args['price'] ?? 0).toDouble(),
    description: args['description'] ?? 'No description',
    image: args['image'] ?? '',   // agar image null ho toh empty string
    colors: List<String>.from(args['colors'] ?? []),
  );
}
  // final product = ProductModel(
  //   name: "Green Armchair",
  //   category: "Chair",
  //   price: 289.99,
  //   description:
  //       "Tieton Armchair\n\nThis armchair is an elegant and functional piece of furniture. "
  //       "It is suitable for family visits and parties with friends and perfect "
  //       "for relaxing in front of the TV after hard work.",
  //   colors: ["#7DC579", "#000000", "#FFFFFF"], // 🔲 3 colors
  //   image: AppImage.chair1,
  // );

  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
     appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined,size: 30,), 
            onPressed: () {
          Get.toNamed("/cartscreen");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         
           
              SizedBox(height: screenHeight*0.06),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category.toUpperCase(),
                          style:  TextStyle(
                              color:AppColor.titlecolor, fontSize: 14),
                        ),
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                       SizedBox(height: screenHeight*0.03),
                        Text(
                          "From \$${product.price}",
                          style:  TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600,),
                        ),
                       SizedBox(height: screenHeight*0.02),
                        Text(
                        "Available Colors",
                          style:  TextStyle(
                              color:AppColor.titlecolor, fontSize: 12),
                        ),
                     
                        Row(
                          children: product.colors.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String hex = entry.value;
                            return ColorOption(
                              color: Color(int.parse("0xFF${hex.substring(1)}")),
                              isSelected: idx == selectedColorIndex,
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = idx;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                
               Image.network(
  product.image,
  height: screenHeight * 0.30,
  width: screenWidth * 0.53,   
  fit: BoxFit.contain,
)
                ],
              ),

              SizedBox(height: screenHeight*0.1),

          
              Text(
                product.description,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const Spacer(),

            
              Padding(
                padding:  EdgeInsets.only(left: screenWidth*0.05),
                child: CustomButton(
                  text: "ADD TO CART",
                  onPressed: () {
                    Get.toNamed("/cartscreen");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
