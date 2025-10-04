import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:model_home_app/Models/cart_model.dart';

import 'package:model_home_app/widgets/button/custom_button.dart';
import 'package:model_home_app/widgets/cards/item_card.dart';


class OrderReviewPage extends StatefulWidget {
  const OrderReviewPage({super.key});

  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  final NumberFormat _currency = NumberFormat.simpleCurrency(locale: 'en_US');

  List<CartItem> items = List.generate(
    4,
    (i) => CartItem(
      name: 'Amet nunc, tincidunt interdum rhoncus massa',
      quantity: i == 0 ? 2 : 1,
      price: 245.78,
    ),
  );

  void _increment(int index) => setState(() => items[index].quantity++);
  void _decrement(int index) => setState(() {
        if (items[index].quantity > 1) items[index].quantity--;
      });
  void _remove(int index) => setState(() => items.removeAt(index));

  double get total => items.fold(0, (sum, it) => sum + it.price * it.quantity);

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
                        if (items.isNotEmpty)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Text('${items.length}',
                                  style: const TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          ),
                      ],
                    ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
      
                  Padding(
                    padding:  EdgeInsets.only(right: screenWidth*0.5,top: screenHeight*0.03),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Order Review',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Text('${items.length} items in cart',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        ],
                      ),
                  ),
              
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox.shrink(),
                itemBuilder: (context, idx) => CartItemTile(
                  item: items[idx],
                  onIncrement: () => _increment(idx),
                  onDecrement: () => _decrement(idx),
                  onRemove: () => _remove(idx),
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
                        const Text('Total',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(_currency.format(total),
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
      ),

    
    );
  }
}
