import 'package:ezcheck_app/helper/db_helper.dart';
import 'package:ezcheck_app/screens/account_screen.dart';
import 'package:ezcheck_app/screens/history_screen.dart';
import 'package:ezcheck_app/screens/payment.dart';
import 'package:ezcheck_app/screens/scan_screen.dart';
import 'package:ezcheck_app/screens/shop_now_screen.dart';
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
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.person_2_rounded,
                color: Color(0xFF31434F),
              ),
              title: Text('Account'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => AccountScreen())),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Color(0xFF31434F),
              ),
              title: Text('History'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => HistoryScreen(
                        totalAmount: 0.0,
                        cartItems: [],
                      )),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: Color(0xFF31434F),
              ),
              title: Text('Shop Now'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ShopNowScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Total Amount: ₱${calculateTotalPrice().toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF31434F),
                    ),
                    onPressed: () async {
                      if (cartItems.isEmpty) {
                        _showEmptyCartDialog();
                      } else {
                        List<Map<String, dynamic>> currentCartItems =
                            await DatabaseHelper().getCartItems();
                        double totalPrice = calculateTotalPrice();
                        _proceedToPayment(totalPrice, currentCartItems);
                      }
                    },
                    child: Text('Proceed to Payment'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    if (cartItems.isNotEmpty)
                      Column(
                        children: cartItems.map((item) {
                          double totalPrice =
                              item['quantity'] * (item['price'] ?? 0.0);

                          return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                '${item['productName']}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price: ₱${item['price'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Quantity: '),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                                Icons.remove_circle_outline),
                                            onPressed: () {
                                              _updateQuantity(item['id'], item['quantity'] - 1, item['price']);
                                            },
                                          ),
                                          Text('${item['quantity']}'),
                                          IconButton(
                                            icon:
                                                Icon(Icons.add_circle_outline),
                                            onPressed: () {
                                              _updateQuantity(item['id'], item['quantity'] + 1, item['price']);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Total Price: ₱${totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF31434F)),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Color(0xFF31434F),
                                ),
                                onPressed: () {
                                  _confirmDelete(item['id']);
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 120,
                            ),
                            Image.asset(
                              'assets/images/empty cart.png',
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Cart is empty.',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanScreen(),
            ),
          );
        },
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Color(0xFF31434F),
      ),
    );
  }

Future<void> _updateQuantity(int itemId, int newQuantity, double price) async {
  if (newQuantity > 0) {
    await DatabaseHelper().updateCartItemQuantity(itemId, newQuantity);

    setState(() {
      // Create a new list with the updated quantity
      cartItems = cartItems.map((item) {
        if (item['id'] == itemId) {
          return {...item, 'quantity': newQuantity};
        } else {
          return item;
        }
      }).toList();
    });
  }
}





Future<void> _proceedToPayment(
  double totalPrice, List<Map<String, dynamic>> currentCartItems) async {
  // Proceed to the payment screen
  bool paymentSuccess = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          PaymentScreen(totalAmount: totalPrice, cartItems: currentCartItems),
    ),
  );

  // Check if the payment was successful
  if (paymentSuccess == true) {
    // Clear the cart if the payment was successful
    await DatabaseHelper().clearCart();
    // Reload the cart items after clearing (optional, depending on your use case)
    await loadCartItems();
  }
}

 Future<void> clearCart() async {
  await DatabaseHelper().clearCart();
  await loadCartItems(); // Reload the cart items after clearing (optional)
}

  Future<void> _showEmptyCartDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Empty Cart'),
          content: Text(
              'Please add a product to your cart before proceeding to payment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
