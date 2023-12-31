class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
