class CartItem {
  final String name;
  final double price;
  final String image;
  final String color;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.color,
    this.quantity = 1,
  });
}
