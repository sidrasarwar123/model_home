import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/constant/app_color.dart';
import 'package:model_home_app/controller/product_category_model.dart';
import 'package:model_home_app/view/screen/home_screen.dart';
import 'package:model_home_app/view/screen/order_review.dart';
import 'package:model_home_app/view/screen/search_screen.dart';

class BottombarScreen extends StatefulWidget {
  @override
  _BottombarScreenState createState() => _BottombarScreenState();
}

class _BottombarScreenState extends State<BottombarScreen> {
  final productController = Get.find<ProductController>();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    OrderReviewPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double navBarHeight = screenHeight * 0.08;
    double iconSize = screenWidth * 0.08;
    double fontSize = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: navBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem(Icons.home, "Home", 0, iconSize, fontSize),
                  navItem(Icons.search, "Search", 1, iconSize, fontSize),
                  //cart Icon with Blue Circle Badge
                  Obx(() {
                    int count = productController.items.length;
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () => _onItemTapped(2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: iconSize,
                                color: _selectedIndex == 2
                                    ? AppColor.buttoncolor
                                    : Colors.grey,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Cart",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: _selectedIndex == 2
                                      ? AppColor.buttoncolor
                                      : Colors.grey,
                                  fontWeight: _selectedIndex == 2
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Small Blue Circle Badge
                        if (count > 0)
                          Positioned(
                            right: -4,
                            top: 2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                count.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                  navItem(Icons.person, "Profile", 3, iconSize, fontSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(
      IconData icon, String label, int index, double iconSize, double fontSize) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: isSelected ? AppColor.buttoncolor : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: isSelected ? AppColor.buttoncolor : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Screen"));
  }
}
