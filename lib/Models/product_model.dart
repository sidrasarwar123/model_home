class ProductModel {
  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String image;
  final List<String> colors;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.colors,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      colors: List<String>.from(map['colors'] ?? []),
    );
  }
}
