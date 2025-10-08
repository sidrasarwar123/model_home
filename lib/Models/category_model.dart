class CategoryModel {
  final String id;
  final String title;
  final String image;
  final String productsCount;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.productsCount,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      productsCount: data['productsCount'] ?? '',
    );
  }
}
