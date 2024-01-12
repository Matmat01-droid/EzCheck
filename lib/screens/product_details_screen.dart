import 'package:ezcheck_app/helper/db_helper.dart';
import 'package:ezcheck_app/models/products.dart';
import 'package:ezcheck_app/screens/cart_screen.dart';
import 'package:ezcheck_app/screens/shop_now_screen.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  void showAddToCartDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Product Added to Cart'),
          content: Text(
              '${widget.product.name} added to your cart. Quantity: $quantity'),
          actions: [
            TextButton(
              onPressed: () async {
                await DatabaseHelper().addToCart(
                    widget.product.name, quantity, widget.product.price);
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopNowScreen(),
                  ),
                );
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper().addToCart(
                    widget.product.name, quantity, widget.product.price);
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: Text('View Cart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: const Color(0xFF31434F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/${widget.product.name.toLowerCase()}.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(widget.product.description),
            SizedBox(height: 16.0),
            Text(
              'Barcode: ${widget.product.barcode}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Price: ₱${widget.product.price.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF31434F),
                  ),
                  onPressed: () async {
                    print(
                        'Added ${widget.product.name} to the cart. Quantity: $quantity');
                    showAddToCartDialog(context);
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
