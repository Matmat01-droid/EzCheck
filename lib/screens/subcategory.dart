// subcategory_screen.dart

import 'package:ezcheck_app/screens/history_screen.dart';
import 'package:ezcheck_app/screens/product_list.dart';
import 'package:ezcheck_app/screens/scan_screen.dart';
import 'package:ezcheck_app/screens/shop_now_screen.dart';
import 'package:flutter/material.dart';

class SubcategoryScreen extends StatefulWidget {
  final String mainCategory;

  SubcategoryScreen({Key? key, required this.mainCategory}) : super(key: key);

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  int _currentIndex = 0;

  List<Map<String, dynamic>> getSubcategories() {
    switch (widget.mainCategory) {
      case 'Beverages':
        return [
          {'name': 'Powdered Drinks', 'icon': Icons.local_drink},
          {'name': 'Carbonated Drinks', 'icon': Icons.bubble_chart},
        ];
      case 'Cleaning Supplies':
        return [
          {'name': 'Dish Soap', 'icon': Icons.local_dining},
          {'name': 'Laundry Essentials', 'icon': Icons.shopping_basket},
        ];
      case 'Snacks':
        return [
          {'name': 'Chips', 'icon': Icons.fastfood},
          {'name': 'Chocolate', 'icon': Icons.fastfood},
        ];
      case 'Pantry Supplies':
        return [
          {'name': 'Canned Goods', 'icon': Icons.food_bank},
          {'name': 'Frozen Foods', 'icon': Icons.free_breakfast},
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> subcategories = getSubcategories();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mainCategory),
        backgroundColor: const Color(0xFF31434F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: subcategories.length,
          itemBuilder: (context, index) {
            String subcategoryName = subcategories[index]['name'];
            IconData subcategoryIcon = subcategories[index]['icon'];
            return GestureDetector(
              onTap: () {
                print('Subcategory tapped: $subcategoryName');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListingScreen(
                      mainCategory: widget.mainCategory,
                      subcategory: subcategoryName,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridTile(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          subcategoryIcon,
                          size: 48.0,
                          color: Color(0xFF31434F),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          subcategoryName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Color(0xFF31434F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
                builder: (context) => ShopNowScreen(),
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
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
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
