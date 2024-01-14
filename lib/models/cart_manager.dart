import 'package:ezcheck_app/models/products.dart';

class CartManager {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
  
  if (_cartItems.any((item) => item.name == product.name)) {
   
    _cartItems.firstWhere((item) => item.name == product.name).quantity += quantity;
  } else {
 
    _cartItems.add(Product(
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      quantity: quantity,
      barcode: product.barcode,
    ));
  }
}


  static final CartManager _instance = CartManager._internal();

  CartManager._internal();

  factory CartManager() {
    return _instance;
  }
}
