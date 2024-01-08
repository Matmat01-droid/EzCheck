import 'package:ezcheck_app/screens/dashboard.dart';
import 'package:ezcheck_app/screens/scan_screen.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  HistoryScreen({Key? key, required this.totalAmount, required this.cartItems})
      : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _currentIndex = 2; // Set the initial index for HistoryScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
        backgroundColor: Color(0xFF31434F),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Amount: ₱${widget.totalAmount.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Text('Purchase Details:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.cartItems.map((item) {
                double totalPrice = item['quantity'] * (item['price'] ?? 0.0);
                return ListTile(
                  title: Text('Product: ${item['productName']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${item['quantity']}'),
                      Text('Total Price: ₱${totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF31434F),
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle item taps to navigate to other screens if needed
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
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
              // For the 'History' item (index 2), we are already on the HistoryScreen
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
}
