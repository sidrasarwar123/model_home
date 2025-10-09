import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:model_home_app/controller/product_category_model.dart';

import 'package:model_home_app/widgets/button/custom_button.dart';
import 'package:model_home_app/widgets/cards/item_card.dart';


class OrderReviewPage extends StatefulWidget {
  const OrderReviewPage({super.key});

  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  final ProductController productController=Get.put(ProductController());
  final NumberFormat _currency = NumberFormat.simpleCurrency(locale: 'en_US');

  

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
          Padding(
            padding:  EdgeInsets.only(right: screenWidth*0.04),
            child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed("/checkout");
                          },
                          icon: const Icon(Icons.shopping_bag_outlined,size: 30,),
                        ),
                        if (productController.items.isNotEmpty)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Text('${productController.items.length}',
                                  style: const TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          ),
                      ],
                    ),
          ),
        ],
      ),
      body: Obx((){
         return SafeArea(
          child: Column(
            children: [
        
                    Padding(
                      padding:  EdgeInsets.only(right: screenWidth*0.5,top: screenHeight*0.03),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Order Review',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            Text('${productController.items.length} items in cart',
                                style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                    ),
                
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  itemCount: productController.items.length,
                  separatorBuilder: (_, __) => const SizedBox.shrink(),
                  
                  itemBuilder: (context, idx) => CartItemTile(
                    
                    item: productController.items[idx],
                    onIncrement: () => productController.increaseQuantity(idx),
                    onDecrement: () => productController.decreaseQuantity(idx),
                    onRemove: () => productController.removeItem(productController.items[idx]),
                  ),
                ),
              ),
        
           
              SafeArea(
                top: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                         Text(_currency.format(productController.total),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    CustomButton(text: "Next", onPressed: (){
                      Get.toNamed("/checkout");
                    }),
                    SizedBox(height: screenHeight*0.1,)
                   
                  ],
                ),
              ),
            ],
          ),
        );
      }
       
      ),

    
    );
  }
}
