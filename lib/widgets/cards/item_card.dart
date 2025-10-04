import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:model_home_app/Models/cart_model.dart';


class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final _currency = NumberFormat.simpleCurrency(locale: 'en_US');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.1,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.inventory_2_outlined,
                    size: 28, color: Colors.blueGrey),
              ),
              SizedBox(width: screenWidth * 0.03),

              // Title + Quantity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: onDecrement,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Icon(Icons.remove, size: 18),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Text('${item.quantity}',
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              GestureDetector(
                                onTap: onIncrement,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Icon(Icons.add, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price + Remove
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: onRemove,
                      splashRadius: 18),
                  const SizedBox(height: 4),
                  Text(_currency.format(item.price),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        // Divider under each item
         Divider(
          thickness: 1,
          height: 3,
          color:Colors.grey.shade200,
        ),
      ],
    );
  }
}
