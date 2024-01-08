import 'package:ezcheck_app/models/products.dart';

class CartManager {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
  // Check if the product is already in the cart
  if (_cartItems.any((item) => item.name == product.name)) {
    // Update the quantity if the product is already in the cart
    _cartItems.firstWhere((item) => item.name == product.name).quantity += quantity;
  } else {
    // Add the product to the cart with the specified quantity
    _cartItems.add(Product(
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      quantity: quantity,
    ));
  }
}

  // Add more methods for removing items, clearing the cart, etc., if needed

  // Singleton pattern
  static final CartManager _instance = CartManager._internal();

  CartManager._internal();

  factory CartManager() {
    return _instance;
  }
}
