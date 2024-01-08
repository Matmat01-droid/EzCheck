// product_listing_screen.dart

import 'package:ezcheck_app/models/products.dart';
import 'package:ezcheck_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductListingScreen extends StatelessWidget {
  final String mainCategory;
  final String subcategory;

  ProductListingScreen(
      {Key? key, required this.mainCategory, required this.subcategory})
      : super(key: key);

  // Sample products for each category
  List<Product> getSampleProducts() {
    switch (mainCategory) {
      case 'Beverages':
        if (subcategory == 'Powdered Drinks') {
          return [
            Product(
              name: 'Milo',
              description: 'Nestle Milo 35g',
              price: 8.00,
              imageUrl: 'assets/images/milo.jpg',
            ),
            Product(
              name: 'Bear Brand',
              description: 'Nestle Bear Brand 320g + 30g',
              price: 50.00,
              imageUrl: 'assets/images/bear brand.jpg',
            ),
            Product(
              name: 'Birch Tree',
              description: 'Birch Tree Fortified 150g',
              price: 9.00,
              imageUrl: 'assets/images/birch tree.jpg',
            ),
            Product(
              name: 'Kopiko',
              description: 'Kopiko Black 3 In One Coffee 25g',
              price: 9.00,
              imageUrl: 'assets/images/kopiko.jpg',
            ),
            Product(
              name: 'Great Taste',
              description: 'Great Taste White Caramel Sachet 30g',
              price: 9.00,
              imageUrl: 'assets/images/great taste.jpg',
            ),
            Product(
              name: 'Energen',
              description: 'Energen Chocolate Cereal 30g',
              price: 8.00,
              imageUrl: 'assets/images/energen.jpg',
            ),
            Product(
              name: 'Tang',
              description: 'Tang Pineapple Instant Drink Mix 25g',
              price: 18.00,
              imageUrl: 'assets/images/tang.jpg',
            ),
          ];
        } else if (subcategory == 'Carbonated Drinks') {
          return [
            Product(
              name: 'Coca-Cola',
              description: 'Coca-Cola 1L',
              price: 65.00,
              imageUrl: 'assets/images/coca-cola.jpg',
            ),
            Product(
              name: 'Pepsi',
              description: 'Pepsi Cola 1L',
              price: 65.00,
              imageUrl: 'assets/images/pepsi.jpg',
            ),
            Product(
              name: 'Sprite',
              description: 'Sprite 1L',
              price: 65.00,
              imageUrl: 'assets/images/sprite.jpg',
            ),
            Product(
              name: 'Royal',
              description: 'Royal 1.5L',
              price: 70.00,
              imageUrl: 'assets/images/royal.jpg',
            ),
            Product(
              name: 'Mountain Dew',
              description: 'B&M Mountain Dew Energy 1L',
              price: 70.00,
              imageUrl: 'assets/images/mountain dew.jpg',
            ),
            Product(
              name: 'Mirinda',
              description: 'Mirinda Orange 1L',
              price: 70.00,
              imageUrl: 'assets/images/mirinda.jpg',
            ),
          ];
        }
        break;
      case 'Cleaning Supplies':
        if (subcategory == 'Dish Soap') {
          return [
            Product(
              name: 'Joy Dishwashing Liquid',
              description: 'Joy Lemon Dishwashing Liquid Bottle 495mL',
              price: 45.00,
              imageUrl: 'assets/images/joy dishwashing liquid.jpg',
            ),
            Product(
              name: 'Smart Dishwashing Paste',
              description: 'Smart Dishwashing Paste Lemon 400g',
              price: 30.00,
              imageUrl: 'assets/images/smart dishwashing paste.jpg',
            ),
            Product(
              name: 'Axion Dishwashing Paste',
              description: 'Axion Antibacterial Dishwashing Paste Lemon 350g',
              price: 30.00,
              imageUrl: 'assets/images/axion dishwashing paste.jpg',
            ),
          ];
        } else if (subcategory == 'Laundry Essentials') {
          return [
            Product(
              name: 'Tide',
              description: 'Tide Powder Detergent with Downy 720g',
              price: 50.00,
              imageUrl: 'assets/images/tide.jpg',
            ),
            Product(
              name: 'Pride',
              description: 'Pride Powder Detergent AntiBac 500g',
              price: 6.00,
              imageUrl: 'assets/images/pride.jpg',
            ),
            Product(
              name: 'Ariel',
              description: 'Ariel Powder 1 KG',
              price: 250.00,
              imageUrl: 'assets/images/ariel.jpg',
            ),
            Product(
              name: 'Surf',
              description: 'Surf Powder Rose Fresh 70g',
              price: 6.00,
              imageUrl: 'assets/images/surf.jpg',
            ),
            Product(
              name: 'Calla',
              description: 'Calla Detergent Powder w/ Fabcon Rose Garden 100g',
              price: 4.99,
              imageUrl: 'assets/images/calla.jpg',
            ),
          ];
        }
        break;
      case 'Snacks':
        if (subcategory == 'Chips') {
          return [
            Product(
              name: 'Piattos',
              description: 'JACK N JILL PIATTOS CHEESE 85g',
              price: 25.00,
              imageUrl: 'assets/images/piattos.jpg',
            ),
            Product(
              name: 'Nova',
              description:
                  'NOVA MULTI-GRAIN SNACKS (Country Cheddar Flavor) 40 grams',
              price: 14.00,
              imageUrl: 'assets/images/nova.jpg',
            ),
            Product(
              name: 'Chippy',
              description: 'Chippy BBQ 110g',
              price: 24.00,
              imageUrl: 'assets/images/chippy.jpg',
            ),
            Product(
              name: 'Clover',
              description: 'Clover Chips Cheese 26G',
              price: 7.00,
              imageUrl: 'assets/images/clover.jpg',
            ),
          ];
        } else if (subcategory == 'Chocolate') {
          return [
            Product(
              name: 'Goya',
              description: 'Goya Milk Chocolate 35G',
              price: 12.00,
              imageUrl: 'assets/images/goya.jpg',
            ),
            Product(
              name: 'Flat Tops',
              description: 'Flat Tops Milk Chocolate 150g',
              price: 20.00,
              imageUrl: 'assets/images/flat tops.jpg',
            ),
            Product(
              name: 'Choco Mucho',
              description: 'Choco Mucho Choco 32g',
              price: 8.00,
              imageUrl: 'assets/images/choco mucho.jpg',
            ),
            Product(
              name: 'Beng Beng',
              description: 'Beng-Beng Chocolate 32g',
              price: 7.00,
              imageUrl: 'assets/images/beng beng.jpg',
            ),
            Product(
              name: 'Cream O',
              description: 'Cream-O Vanilla/Chocolate Sandwich Cookies 10pcs',
              price: 7.00,
              imageUrl: 'assets/images/cream o.jpg',
            ),
          ];
        }

      case 'Pantry Supplies':
        if (subcategory == 'Frozen Foods') {
          return [
            Product(
              name: 'Tender Juicy',
              description: 'Purefoods Tender Juicy Jumbo 1kg',
              price: 150.00,
              imageUrl: 'assets/images/tender juicy.jpg',
            ),
            Product(
              name: 'Idol',
              description: 'Cdo Idol Cheesedog Regular 1KG',
              price: 150.00,
              imageUrl: 'assets/images/idol.jpg',
            ),
            Product(
              name: 'Funtastyk',
              description: 'Funtastyk Young Pork Tocino Flat-Pack 225G',
              price: 60.00,
              imageUrl: 'assets/images/funtastyk.jpg',
            ),
            Product(
              name: 'Bingo',
              description: 'Bingo Chicken Nuggets 200g',
              price: 50.00,
              imageUrl: 'assets/images/bingo.jpg',
            ),
          ];
        } else if (subcategory == 'Canned Goods') {
          return [
            Product(
              name: 'Youngs Town',
              description: 'Youngs Town Premium Sardines Regular 155g',
              price: 25.00,
              imageUrl: 'assets/images/youngs town.jpg',
            ),
            Product(
              name: 'Century Tuna',
              description: 'Century Tuna Flakes in Oil 155g ',
              price: 28.00,
              imageUrl: 'assets/images/century tuna.jpg',
            ),
            Product(
              name: 'Fresca Tuna',
              description: 'Fresca Tuna Flakes Afritada 175g ',
              price: 20.00,
              imageUrl: 'assets/images/fresca tuna.jpg',
            ),
            Product(
              name: 'Argentina',
              description: 'Argentina Corned Beef 150g',
              price: 35.00,
              imageUrl: 'assets/images/argentina.jpg',
            ),
            Product(
              name: 'King Cup',
              description: 'King Cup Sardine 155g',
              price: 20.00,
              imageUrl: 'assets/images/king cup.jpg',
            ),
          ];
        }

      // Add cases for other categories as needed
      default:
        return [];
    }
    throw Exception('Invalid mainCategory or subcategory');
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = getSampleProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('$mainCategory - $subcategory Products'),
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
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            return GestureDetector(
              onTap: () {
                // Handle product tap, navigate to product details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridTile(
                  child: Image.asset(
                    // Use Image.asset for displaying images from assets
                    'assets/images/${product.name.toLowerCase()}.jpg',
                    fit: BoxFit.cover,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Color(0xFF31434F).withOpacity(0.5),
                    title: Text(product.name),
                    subtitle: Text('\₱${product.price.toStringAsFixed(2)}'),
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
