import 'package:ezcheck_app/screens/category_details.dart';
import 'package:flutter/material.dart';

class ShopNowScreen extends StatelessWidget {
  const ShopNowScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Now'),
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
            // Add more categories as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () async {
        // Handle the category click here, for example, navigate to a new screen
        // or perform some other action.
        print('Category clicked: $title');
        // Example: Navigate to a new screen
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(categoryTitle: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                  color: Colors.black,
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
