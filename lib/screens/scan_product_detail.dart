import 'package:flutter/material.dart';

class ScannedProductDetailsScreen extends StatelessWidget {
  final String barcode;

  const ScannedProductDetailsScreen({required this.barcode});

  @override
  Widget build(BuildContext context) {
    // Add your logic to fetch product details based on the scanned barcode
    // For demonstration purposes, I'm displaying the barcode as the product details.

    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Product Details'),
        backgroundColor: const Color(0xFF31434F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Details for Barcode: $barcode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Add more product details widgets here based on your data
            // For example:
            Text('Product Name: ...'),
            Text('Price: ...'),
            // ... other product details
          ],
        ),
      ),
    );
  }
}
