import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/Models/cart_model.dart';
import 'package:model_home_app/controller/product_category_model.dart';
import 'package:model_home_app/widgets/button/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ProductController productController = Get.put(ProductController());

final List<CartItem> orderItems = ProductController.to.items.toList();

 
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String selectedState = "California";
  bool sameAddress = false;
  bool createAccount = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, size: 30),
            onPressed: () {
              // Get.toNamed("/cartscreen");
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Billing Address",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight * 0.02),

          Row(
            children: [
              Expanded(child: _buildTextField("First Name", firstNameController)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("Last Name", lastNameController)),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          _buildTextField("Email Address", emailController),
          SizedBox(height: screenHeight * 0.02),

          _buildTextField("Street Address", streetController),
          SizedBox(height: screenHeight * 0.02),

          Row(
            children: [
              Expanded(child: _buildTextField("Zip/Postal Code", zipController)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("Phone", phoneController)),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedState,
                  decoration: const InputDecoration(
                    labelText: "State/Province",
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: "California", child: Text("California")),
                    DropdownMenuItem(value: "Texas", child: Text("Texas")),
                    DropdownMenuItem(value: "New York", child: Text("New York")),
                  ],
                  onChanged: (val) => setState(() => selectedState = val!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("City", cityController)),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

         CheckboxListTile(
            value: sameAddress,
            onChanged: (val) => setState(() => sameAddress = val ?? false),
            title: const Text("My billing and shipping address are the same"),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            value: createAccount,
            onChanged: (val) => setState(() => createAccount = val ?? false),
            title: const Text("Create an account for later use"),
            controlAffinity: ListTileControlAffinity.leading,
          ),

          // 🔹 Password fields only visible if createAccount == true
          if (createAccount) ...[
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(child: _buildTextField("Password",passwordController,isPassword: true)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildTextField("Confirm Password", passwordController,isPassword: true)),
              ],
            ),
          ],
          SizedBox(height: screenHeight * 0.02),

          isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  text: "Submit",
                  onPressed: _submitOrder,
                ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

Future<void> _submitOrder() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    Get.snackbar("Error", "Please login before placing an order");
    return;
  }

  if (firstNameController.text.isEmpty ||
      lastNameController.text.isEmpty ||
      emailController.text.isEmpty ||
      streetController.text.isEmpty ||
      zipController.text.isEmpty ||
      phoneController.text.isEmpty ||
      cityController.text.isEmpty) {
    Get.snackbar("Error", "Please fill all required fields");
    return;
  }

  try {
    setState(() => isLoading = true);

    // Prepare order items
    List<Map<String, dynamic>> orderItems = ProductController.to.items.map((item) => {
    
      "title": item.name,
      "price": item.price,
      "qty": item.quantity,
    }).toList();

    // Calculate total price
    double totalAmount = ProductController.to.total;

    // Prepare order data
    final orderData = {
      'userId': user.uid,
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': "${streetController.text.trim()}, ${cityController.text.trim()}, $selectedState",
      'zipCode': zipController.text.trim(),
      'status': 'pending', 
      'timestamp': FieldValue.serverTimestamp(),
      'total': totalAmount,
      'orderItems': orderItems,
    };

    // Save in  orders collection
    await FirebaseFirestore.instance.collection("orders").add(orderData);

    setState(() => isLoading = false);

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(" Order Placed"),
        content: const Text("Your order has been successfully placed."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed("/bottombar");
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    // Clear cart
    ProductController.to.clearCart();

  } catch (e) {
    setState(() => isLoading = false);
    Get.snackbar("Error", e.toString());
  }
}
}