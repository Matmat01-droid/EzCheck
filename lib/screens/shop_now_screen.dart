import 'package:ezcheck_app/screens/cart_screen.dart';
import 'package:ezcheck_app/screens/history_screen.dart';
import 'package:ezcheck_app/screens/scan_screen.dart';
import 'package:ezcheck_app/screens/subcategory.dart';
import 'package:flutter/material.dart';

class ShopNowScreen extends StatefulWidget {
  ShopNowScreen({Key? key});

  @override
  State<ShopNowScreen> createState() => _ShopNowScreenState();
}

class _ShopNowScreenState extends State<ShopNowScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All'),
        backgroundColor: const Color(0xFF31434F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildCategory(context, 'Beverages', Icons.local_drink),
            _buildCategory(
                context, 'Cleaning Supplies', Icons.cleaning_services),
            _buildCategory(context, 'Snacks', Icons.food_bank),
            _buildCategory(context, 'Pantry Supplies', Icons.breakfast_dining),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF31434F),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanScreen(),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryScreen(
                  totalAmount: 0.0,
                  cartItems: [],
                ),
              ),
            );
          }
        },
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout),
            label: 'Cart',
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

  Widget _buildCategory(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () async {
        // Handle the category click here
        print('Category clicked: $title');
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryScreen(mainCategory: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF31434F),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: GridTile(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 48.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
