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
  bool isDismissible = false; 

  @override
  void initState() {
    super.initState();
    readPurchaseHistory();
  }

  Future<void> readPurchaseHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> purchaseHistoryStrings =
        prefs.getStringList('purchaseHistory') ?? [];

    List<Map<String, dynamic>> history = purchaseHistoryStrings
        .map<Map<String, dynamic>>((jsonString) => jsonDecode(jsonString))
        .toList();

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
                    .check) 
                : Icon(Icons.delete),
            onPressed: () {
              setState(() {
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

                  String formattedDate = _formatDate(purchase['date']);

                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      _removeItem(index);
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
            icon: Icon(Icons.qr_code_scanner),
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

  void _removeItem(int index) {
    setState(() {
      purchaseHistory.removeAt(index);
    });
    updatePurchaseHistory();
  }

  void _addItem(int index, Map<String, dynamic> item) {
    setState(() {
      purchaseHistory.insert(index, item);
    });
    updatePurchaseHistory();
  }

  Future<void> updatePurchaseHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    purchaseHistory.forEach((purchase) {
      purchase['date'] = DateTime.now().toString();
    });
    List<String> purchaseHistoryStrings =
        purchaseHistory.map((purchase) => jsonEncode(purchase)).toList();
    prefs.setStringList('purchaseHistory', purchaseHistoryStrings);
  }
}
