import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final String productsCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.productsCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth*0.5,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(image, height:screenHeight*0.2),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(productsCount, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
