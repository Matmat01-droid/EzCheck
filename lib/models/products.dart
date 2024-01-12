class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String barcode; // Add the barcode field
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.barcode, // Initialize the barcode in the constructor
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'barcode': barcode, // Include barcode in the map
      'quantity': quantity,
    };
  }
}
