import 'package:ezcheck_app/helper/db_helper.dart';
import 'package:ezcheck_app/models/products.dart';
import 'package:ezcheck_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryTitle;

  CategoryDetailsScreen({Key? key, required this.categoryTitle})
      : super(key: key);

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late List<Product> products = []; // Initialize products as an empty list

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
     print('_initialize start');
  await _loadProducts();
  print('_initialize end');
  }

  Future<void> _loadProducts() async {
    final List<Map<String, dynamic>> productData =
        await dbHelper.getProductsByCategory(widget.categoryTitle);
    setState(() {
      products = productData
          .map((data) => Product(
                name: data['name'],
                description: data['description'],
                price: data['price'],
                imageUrl: data['imageUrl'],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        backgroundColor: const Color(0xFF31434F),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('${product.description}\n\$${product.price}'),
            onTap: () async {
              // Handle product click, e.g., navigate to product details screen
              print('Product clicked: ${product.name}');
              // Example: Navigate to a new screen
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
