import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var categories = <CategoryModel>[].obs;
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
    
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading(true);

      // 🔹 Fetch categories
      final categorySnapshot = await _firestore.collection('categories').get();
      categories.value = categorySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();

  
      final productSnapshot = await _firestore.collection('products').get();
      products.value = productSnapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching home data: $e");
    } finally {
      isLoading(false);
    }
  }

  
  
}

