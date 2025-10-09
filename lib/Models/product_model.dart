class ProductModel {
  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final List<String> colors;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.colors,
    required this.image,
  });
  //isy ma ny peoduct ky lia bi use kia ha and is sy ma ny argument pass karway ha 
  // Convert Firestore Model
  factory ProductModel.fromMap(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      colors: List<String>.from(data['colors'] ?? []),
      image: data['image'] ?? '',
    );
  }

  // Convert Model → Map (for uploading)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'price': price,
      'description': description,
      'colors': colors,
      'image': image,
    };
  }
}
