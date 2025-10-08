import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = <ProductModel>[].obs; 
  var allProducts = <ProductModel>[].obs; 
  var categories = <CategoryModel>[].obs;

  /// Fetch all categories (for SearchScreen)
  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      categories.value = snapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch products by specific category
  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      isLoading(true);

      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .get();

      final fetchedProducts = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();

      allProducts.assignAll(fetchedProducts);
      products.assignAll(fetchedProducts);
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch all products (from all categories)
  Future<void> fetchAllProducts() async {
    try {
      isLoading(true);

      final snapshot =
          await FirebaseFirestore.instance.collectionGroup('products').get();

      final fetchedProducts = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();

      allProducts.assignAll(fetchedProducts);
      products.assignAll(fetchedProducts);
    } catch (e) {
      print("Error fetching all products: $e");
    } finally {
      isLoading(false);
    }
  }

  /// 🔍 Search function (filters from backup list)
  void searchProducts(String query) {
    if (query.isEmpty) {
      products.assignAll(allProducts); // reset
    } else {
      final result = allProducts.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()));
      products.assignAll(result);
      print("🔎 Found ${products.length} results for '$query'");
    }
  }
}
