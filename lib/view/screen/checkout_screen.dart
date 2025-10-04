import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_home_app/widgets/button/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool sameAddress = false;
  bool createAccount = true;

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
            icon: const Icon(Icons.shopping_bag_outlined, size: 30),
            onPressed: () {
              Get.toNamed("/cartscreen");
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
              Expanded(child: _buildTextField("First Name")),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("Last Name")),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          _buildTextField("Email Address"),
          SizedBox(height: screenHeight * 0.02),

          _buildTextField("Street Address"),
          SizedBox(height: screenHeight * 0.02),

          Row(
            children: [
              Expanded(child: _buildTextField("Zip/Postal Code")),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("Phone")),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: "California",
                  decoration: const InputDecoration(
                    labelText: "State/Province",
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: "California", child: Text("California")),
                    DropdownMenuItem(value: "Texas", child: Text("Texas")),
                    DropdownMenuItem(value: "New York", child: Text("New York")),
                  ],
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("City")),
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

          Row(
            children: [
              Expanded(child: _buildTextField("Password", isPassword: true)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField("Confirm Password", isPassword: true)),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

        CustomButton(
  text: "Submit",
  onPressed: () {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("🎉 Congratulations!"),
        content: const Text("Your order has been placed successfully."),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  },
),

        ],
      ),
    );
  }

  Widget _buildTextField(String label, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
