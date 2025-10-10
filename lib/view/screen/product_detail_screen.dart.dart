import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/Models/cart_model.dart';

import 'package:model_home_app/constant/app_color.dart';
import 'package:model_home_app/controller/product_category_model.dart';

import 'package:model_home_app/widgets/button/custom_button.dart';

import '../../../widgets/color_option.dart';


class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductController productController = Get.put(ProductController());
  int selectedColorIndex = 0;
    late String title;
  late String category;
  late double price;
  late String description;
  late List<String> colors;
  late String image;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    title = args['title'];
    category = args['category'];
    price = args['price'];
    description = args['description'];
    colors = List<String>.from(args['colors']);
    image = args['image'];
  }

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
                        Text(category.toUpperCase(),
                          
        
                          style:  TextStyle(
                              color:AppColor.titlecolor, fontSize: 16),
                        ),
                        Text(title,
                          // product.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                       SizedBox(height: screenHeight*0.03),
                        Text(
                          "From \$${price.toStringAsFixed(2)}",
                          style:  TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600,),
                        ),
                       SizedBox(height: screenHeight*0.02),
                        Text(

                       "Available Colors",
                          style:  TextStyle(
                              color:AppColor.titlecolor, fontSize: 12),
                        ),
                     SizedBox(height: screenHeight*0.03,),
                        Row(
                          children: colors.asMap().entries.map((entry) {
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
  image,
  height: screenHeight * 0.30,
  width: screenWidth * 0.53,   
  fit: BoxFit.contain,
)
                ],
              ),
                  SizedBox(height: screenHeight*0.03),
                           Text(title,
                          // product.name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
              SizedBox(height: screenHeight*0.01),
           
          
              Text(
                description,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const Spacer(),

            
              Padding(
                padding:  EdgeInsets.only(left: screenWidth*0.05),
                child: Obx(() => CustomButton(
  text: "ADD TO CART",
  isloading: productController.isLoading.value,
  onPressed: () async {
    await productController.addToCart(
      CartItem(
        name: title,
        price: price,
        image: image,
        color: colors[selectedColorIndex],
      ),
    );
   
    Get.toNamed("/cartscreen");
  },
)),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
