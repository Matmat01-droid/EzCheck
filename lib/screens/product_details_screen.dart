import 'package:ezcheck_app/models/products.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: const Color(0xFF31434F),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(product.imageUrl),
          const SizedBox(height: 16.0),
          Text('${product.description}\n\$${product.price}'),
          const SizedBox(height: 16.0),
          // Add buttons for quantity and add to cart
          ElevatedButton(
            onPressed: () {
              _showQuantityDialog(context);
            },
            child: Text('Select Quantity'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle add to cart button click
              // You may want to add the product to a cart state
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

Future<void> _showQuantityDialog(BuildContext context) async {
  int selectedQuantity = 1; // Default quantity

  await showDialog<int>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Select Quantity'),
        content: Column(
          children: [
            Text('Choose the quantity:'),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: selectedQuantity.toString(),
              onChanged: (value) {
                selectedQuantity = int.tryParse(value) ?? 1;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, selectedQuantity);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
  // The selectedQuantity can be used here for further processing
}
