// subcategory_screen.dart

import 'package:ezcheck_app/screens/product_list.dart';
import 'package:flutter/material.dart';

class SubcategoryScreen extends StatelessWidget {
  final String mainCategory;

  SubcategoryScreen({Key? key, required this.mainCategory}) : super(key: key);

  List<Map<String, dynamic>> getSubcategories() {
    // Function to get subcategories based on the selected main category
    switch (mainCategory) {
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
          // Add more subcategories for Snacks as needed
        ];
      case 'Pantry Supplies':
        return [
          {'name': 'Canned Goods', 'icon': Icons.food_bank},
          {'name': 'Frozen Foods', 'icon': Icons.free_breakfast},
          // Add more subcategories for Pantry Supplies as needed
        ];
      // Add cases for other categories as needed
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> subcategories = getSubcategories();

    return Scaffold(
      appBar: AppBar(
        title: Text(mainCategory),
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
                // Handle subcategory click here
                print('Subcategory tapped: $subcategoryName');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListingScreen(
                      mainCategory: mainCategory,
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
    );
  }
}
