import 'package:ezcheck_app/helper/db_helper.dart';
import 'package:ezcheck_app/screens/payment.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    List<Map<String, dynamic>> items = await DatabaseHelper().getCartItems();

    setState(() {
      cartItems = items;
    });
  }

  Future<void> _confirmDelete(int itemId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteItem(itemId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(int itemId) async {
    await DatabaseHelper().deleteCartItem(itemId);
    loadCartItems();
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item['quantity'] * (item['price'] ?? 0.0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Color(0xFF31434F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              if (cartItems.isNotEmpty)
                Column(
                  children: cartItems.map((item) {
                    // Check if price is not null before calculating total price
                    double totalPrice =
                        item['quantity'] * (item['price'] ?? 0.0);

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('Product: ${item['productName']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity: '),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        _updateQuantity(
                                            item['id'], item['quantity'] - 1);
                                      },
                                    ),
                                    Text('${item['quantity']}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        _updateQuantity(
                                            item['id'], item['quantity'] + 1);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                                'Total Price: ₱${totalPrice.toStringAsFixed(2)}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _confirmDelete(item['id']);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(height: 10),
              Text(
                'Total Price: ₱${calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF31434F),
                    ),
                    onPressed: () async {
                      List<Map<String, dynamic>> currentCartItems =
                          await DatabaseHelper().getCartItems();
                      double totalPrice = calculateTotalPrice();
                      _proceedToPayment(totalPrice, currentCartItems);
                    },
                    child: Text('Proceed to Payment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateQuantity(int itemId, int newQuantity) async {
    await DatabaseHelper().updateCartItemQuantity(itemId, newQuantity);
    loadCartItems();
  }

  Future<void> _proceedToPayment(
      double totalPrice, List<Map<String, dynamic>> currentCartItems) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PaymentScreen(totalAmount: totalPrice, cartItems: currentCartItems),
      ),
    );
  }
}
