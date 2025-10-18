import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:model_home_app/Models/category_model.dart';
import 'package:model_home_app/Models/product_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var categories = <CategoryModel>[].obs;
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  void fetchCategories() {
    _firestore.collection('categories').snapshots().listen((snapshot) {
      categories.value = snapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();
      isLoading.value = false;
    });
  }

  void fetchProducts() {
    _firestore.collection('products').snapshots().listen((snapshot) {
      products.value = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
      isLoading.value = false;
    });
  }
}
