import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:model_home_app/Models/cart_model.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var products = <ProductModel>[].obs; 
  var allProducts = <ProductModel>[].obs; 
  var categories = <CategoryModel>[].obs;
  var items = <CartItem>[].obs;

  static ProductController get to => Get.find<ProductController>();

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

  /// Search function
  void searchProducts(String query) {
    if (query.isEmpty) {
      products.assignAll(allProducts);
    } else {
      final result = allProducts.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()));
      products.assignAll(result);
      print(" Found ${products.length} results for '$query'");
    }
  }

  ///  Add to cart
  Future<void> addToCart(CartItem item) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); 

      int index = items.indexWhere((e) => e.name == item.name);
      if (index >= 0) {
        items[index].quantity++;
      } else {
        items.add(item);
      }

      items.refresh();
    } catch (e) {
      print("Error adding to cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Remove item
  void removeItem(CartItem item) => items.remove(item);

  /// ➕ Increase quantity
  void increaseQuantity(int index) {
    items[index].quantity++;
    items.refresh();
  }

  /// ➖ Decrease quantity
  void decreaseQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
      items.refresh();
    }
  }

  ///  Total price
  double get total =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  ///  Clear cart after checkout
  void clearCart() {
    items.clear();
  }
}
