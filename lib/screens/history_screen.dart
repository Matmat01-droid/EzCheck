import 'dart:convert';

import 'package:ezcheck_app/screens/cart_screen.dart';
import 'package:ezcheck_app/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  HistoryScreen({
    Key? key,
    required this.totalAmount,
    required this.cartItems,
  }) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _currentIndex = 2;
  List<Map<String, dynamic>> purchaseHistory = [];
  bool isDismissible = false; // Track whether items should be dismissible

  @override
  void initState() {
    super.initState();
    readPurchaseHistory();
  }

  Future<void> readPurchaseHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> purchaseHistoryStrings =
        prefs.getStringList('purchaseHistory') ?? [];

    // Convert the list of JSON strings to a list of maps
    List<Map<String, dynamic>> history = purchaseHistoryStrings
        .map<Map<String, dynamic>>((jsonString) => jsonDecode(jsonString))
        .toList();

    // Set the current date for items with a null 'date' property
    history.forEach((purchase) {
      purchase['date'] ??= DateTime.now().toString();
    });

    setState(() {
      purchaseHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
        backgroundColor: Color(0xFF31434F),
        actions: [
          IconButton(
            icon: isDismissible
                ? Icon(Icons
                    .check) // Change icon to check when isDismissible is true
                : Icon(Icons.delete), // Otherwise, show delete icon
            onPressed: () {
              setState(() {
                // Toggle dismissible items when the delete icon is clicked
                isDismissible = !isDismissible;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Purchase Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: purchaseHistory.length,
                itemBuilder: (context, index) {
                  final purchase = purchaseHistory[index];
                  double totalAmount = purchase['totalAmount'] ?? 0.0;
                  List<Map<String, dynamic>> cartItems =
                      (purchase['cartItems'] as List<dynamic>?)
                              ?.cast<Map<String, dynamic>>()
                              .toList() ??
                          [];

                  // Format the date using the intl package
                  String formattedDate = _formatDate(purchase['date']);

                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      _removeItem(index);

                      // Show Snackbar with Undo button
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Purchase deleted'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              _addItem(index, purchase);
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'Total Amount: ₱${totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 5),
                            // Display individual cart items for this purchase
                            ...cartItems.map((item) {
                              double totalPrice =
                                  item['quantity'] * (item['price'] ?? 0.0);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item['productName']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('Quantity: ${item['quantity']}'),
                                  Text(
                                    'Total Price: ₱${totalPrice.toStringAsFixed(2)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }).toList(),

                            // Display the date in the trailing
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date of Purchase: $formattedDate',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Set dismissible property dynamically
                    // based on the isDismissible variable
                    direction: isDismissible
                        ? DismissDirection.endToStart
                        : DismissDirection.none,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF31434F),
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanScreen(),
                  ),
                );
                break;
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.barcode_reader),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  // Helper function to format the date
  String _formatDate(String? dateString) {
    try {
      if (dateString != null) {
        DateTime date = DateTime.parse(dateString);
        return DateFormat('MMM dd yyyy').format(date);
      }
    } catch (e) {
      print('Error formatting date: $e');
    }
    return 'Invalid Date';
  }

  // Function to remove an item from the list
  void _removeItem(int index) {
    setState(() {
      purchaseHistory.removeAt(index);
    });
    updatePurchaseHistory();
  }

  // Function to add an item back to the list
  void _addItem(int index, Map<String, dynamic> item) {
    setState(() {
      purchaseHistory.insert(index, item);
    });
    updatePurchaseHistory();
  }

  // Function to update SharedPreferences with the modified purchaseHistory
  Future<void> updatePurchaseHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Add the current date to each purchase item
    purchaseHistory.forEach((purchase) {
      purchase['date'] = DateTime.now().toString();
    });
    List<String> purchaseHistoryStrings =
        purchaseHistory.map((purchase) => jsonEncode(purchase)).toList();
    prefs.setStringList('purchaseHistory', purchaseHistoryStrings);
  }
}
