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
                name: 'Milo 35g',
                description: 'Nestle Milo 35g',
                price: 8.00,
                imageUrl: 'assets/images/milo 35g.jpg',
                barcode: '1234567890'),
            Product(
                name: 'Bear Brand 320g',
                description: 'Nestle Bear Brand 320g + 30g',
                price: 50.00,
                imageUrl: 'assets/images/bear brand 320g.jpg',
                barcode: '1234567891'),
            Product(
                name: 'Birch Tree Fortified 33g',
                description: 'Birch Tree Fortified 33g',
                price: 9.00,
                imageUrl: 'assets/images/birch tree fortified 33g.jpg',
                barcode: '748485401492'),
            Product(
                name: 'Kopiko 25g',
                description: 'Kopiko Black 3 In One Coffee 25g',
                price: 9.00,
                imageUrl: 'assets/images/kopiko 25g.jpg',
                barcode: '1234567893'),
            Product(
                name: 'Great Taste White Caramel 30g',
                description: 'Great Taste White Caramel Sachet 30g',
                price: 9.00,
                imageUrl: 'assets/images/great taste white caramel 30g.jpg',
                barcode: '1234567894'),
            Product(
                name: 'Energen Chocolate 30g',
                description: 'Energen Chocolate Cereal 30g',
                price: 8.00,
                imageUrl: 'assets/images/energen chocolate 30g.jpg',
                barcode: '1234567895'),
            Product(
                name: 'Tang Pineapple 25g',
                description: 'Tang Pineapple Instant Drink Mix 25g',
                price: 18.00,
                imageUrl: 'assets/images/tang pineapple 25g.jpg',
                barcode: '1234567896'),
            Product(
                name: 'Alaska Fortified 33g',
                description: 'Alaska Powdered Milk Drink 33g',
                price: 9.00,
                imageUrl: 'assets/images/alaska fortified 33g.jpg',
                barcode: '1234567897'),
          ];
        } else if (subcategory == 'Carbonated Drinks') {
          return [
            Product(
                name: 'Coca-Cola 1L',
                description: 'Coca-Cola 1L',
                price: 65.00,
                imageUrl: 'assets/images/coca-cola 1l.jpg',
                barcode: '2345678901'),
            Product(
                name: 'Pepsi 1L',
                description: 'Pepsi Cola 1L',
                price: 65.00,
                imageUrl: 'assets/images/pepsi 1l.jpg',
                barcode: '2345678902'),
            Product(
                name: 'Sprite 1L',
                description: 'Sprite 1L',
                price: 65.00,
                imageUrl: 'assets/images/sprite 1l.jpg',
                barcode: '2345678903'),
            Product(
                name: 'Royal 1.5L',
                description: 'Royal 1.5L',
                price: 70.00,
                imageUrl: 'assets/images/royal 1.5l.jpg',
                barcode: '2345678904'),
            Product(
                name: 'Mountain Dew 1L',
                description: 'B&M Mountain Dew Energy 1L',
                price: 70.00,
                imageUrl: 'assets/images/mountain dew 1l.jpg',
                barcode: '2345678905'),
            Product(
                name: 'Mirinda Orange 1L',
                description: 'Mirinda Orange 1L',
                price: 70.00,
                imageUrl: 'assets/images/mirinda orange 1l.jpg',
                barcode: '2345678906'),
            Product(
                name: 'Coke Mismo 300ML',
                description: 'Coke Mismo 300ML',
                price: 15.00,
                imageUrl: 'assets/images/coke mismo 300ml.jpg',
                barcode: '2345678907'),
            Product(
                name: 'Royal Mismo 250ML',
                description: 'Coke Mismo 300ML',
                price: 15.00,
                imageUrl: 'assets/images/royal mismo 250ml.jpg',
                barcode: '2345678908'),
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
                barcode: '3456789011'),
            Product(
                name: 'Smart Dishwashing Paste',
                description: 'Smart Dishwashing Paste Lemon 400g',
                price: 30.00,
                imageUrl: 'assets/images/smart dishwashing paste.jpg',
                barcode: '3456789012'),
            Product(
                name: 'Axion Dishwashing Paste',
                description: 'Axion Antibacterial Dishwashing Paste Lemon 350g',
                price: 30.00,
                imageUrl: 'assets/images/axion dishwashing paste.jpg',
                barcode: '3456789013'),
          ];
        } else if (subcategory == 'Laundry Essentials') {
          return [
            Product(
                name: 'Tide Powder 720g',
                description: 'Tide Powder Detergent with Downy 720g',
                price: 50.00,
                imageUrl: 'assets/images/tide powder 720g.jpg',
                barcode: '4567890121'),
            Product(
                name: 'Pride Powder 500g',
                description: 'Pride Powder Detergent AntiBac 500g',
                price: 6.00,
                imageUrl: 'assets/images/pride powder 500g.jpg',
                barcode: '4567890122'),
            Product(
                name: 'Ariel Powder 1kg',
                description: 'Ariel Powder 1 KG',
                price: 250.00,
                imageUrl: 'assets/images/ariel powder 1kg.jpg',
                barcode: '4567890123'),
            Product(
                name: 'Surf Rose Fresh 70g',
                description: 'Surf Powder Rose Fresh 70g',
                price: 6.00,
                imageUrl: 'assets/images/surf rose fresh 70g.jpg',
                barcode: '4567890124'),
            Product(
                name: 'Calla Powder 100g',
                description:
                    'Calla Detergent Powder w/ Fabcon Rose Garden 100g',
                price: 7.00,
                imageUrl: 'assets/images/calla powder 100g.jpg',
                barcode: '4567890125'),
          ];
        }
        break;
      case 'Snacks':
        if (subcategory == 'Chips') {
          return [
            Product(
                name: 'Piattos Cheese 85g',
                description: 'JACK N JILL PIATTOS CHEESE 85g',
                price: 25.00,
                imageUrl: 'assets/images/piattos cheese 85g.jpg',
                barcode: '5678901231'),
            Product(
                name: 'Nova Multigrain Snack 40g',
                description:
                    'NOVA MULTI-GRAIN SNACKS (Country Cheddar Flavor) 40 grams',
                price: 14.00,
                imageUrl: 'assets/images/nova multigrain snack 40g.jpg',
                barcode: '5678901232'),
            Product(
                name: 'Chippy BBQ 110g',
                description: 'Chippy BBQ 110g',
                price: 24.00,
                imageUrl: 'assets/images/chippy bbq 110g.jpg',
                barcode: '5678901233'),
            Product(
                name: 'Clover Chips Cheese 26g',
                description: 'Clover Chips Cheese 26G',
                price: 7.00,
                imageUrl: 'assets/images/clover chips cheese 26g.jpg',
                barcode: '5678901234'),
                Product(
                name: 'Martys Cracklings Salt and Vinegar 26g',
                description: 'Martys Cracklings Salt and Vinegar 26g',
                price: 7.00,
                imageUrl: 'assets/images/martys cracklings salt and vinegar 26g.jpg',
                barcode: '5678901235'),
                Product(
                name: 'Oishi Cracklings 50g',
                description: 'Oishi Cracklings 50g',
                price: 7.00,
                imageUrl: 'assets/images/oishi cracklings 50g.jpg',
                barcode: '5678901236'),
                Product(
                name: 'Oishi Crispy Patata 24g',
                description: 'Oishi Crispy Patata 24g',
                price: 7.00,
                imageUrl: 'assets/images/oishi cripsy patata 24g.jpg',
                barcode: '5678901237'),
                Product(
                name: 'Oishi Prawn Crackers Spicy 60g',
                description: 'Oishi Prawn Crackers Spicy 60g',
                price: 7.00,
                imageUrl: 'assets/images/oishi prawn crackers spicy 60g.jpg',
                barcode: '5678901238'),
          ];
        } else if (subcategory == 'Chocolate') {
          return [
            Product(
                name: 'Goya Milk Chocolate 35g',
                description: 'Goya Milk Chocolate 35G',
                price: 12.00,
                imageUrl: 'assets/images/goya milk chocolate 35g.jpg',
                barcode: '6789012341'),
            Product(
                name: 'Flat Tops 150g',
                description: 'Flat Tops Milk Chocolate 150g',
                price: 20.00,
                imageUrl: 'assets/images/flat tops 150g.jpg',
                barcode: '6789012342'),
            Product(
                name: 'Choco Mucho 32g',
                description: 'Choco Mucho Choco 32g',
                price: 8.00,
                imageUrl: 'assets/images/choco mucho 32g.jpg',
                barcode: '6789012343'),
            Product(
                name: 'Beng Beng Chocolate 32g',
                description: 'Beng-Beng Chocolate 32g',
                price: 7.00,
                imageUrl: 'assets/images/beng beng chocolate 32g.jpg',
                barcode: '6789012344'),
            Product(
                name: 'Cream O Vanilla Chocolate Cookies 10pcs',
                description: 'Cream-O Vanilla/Chocolate Sandwich Cookies 10pcs',
                price: 60.00,
                imageUrl:
                    'assets/images/cream o vanilla chocolate cookies 10pcs.jpg',
                barcode: '6789012345'),
          ];
        }

      case 'Pantry Supplies':
        if (subcategory == 'Frozen Foods') {
          return [
            Product(
                name: 'Tender Juicy Jumbo 1kg',
                description: 'Purefoods Tender Juicy Jumbo 1kg',
                price: 150.00,
                imageUrl: 'assets/images/tender juicy jumbo 1kg.jpg',
                barcode: '7890123451'),
            Product(
                name: 'Idol Cheesedog Regular 1kg',
                description: 'Cdo Idol Cheesedog Regular 1KG',
                price: 150.00,
                imageUrl: 'assets/images/idol cheesedog regular 1kg.jpg',
                barcode: '7890123452'),
            Product(
                name: 'Funtastyk Young Pork Tocino 225g',
                description: 'Funtastyk Young Pork Tocino Flat-Pack 225G',
                price: 60.00,
                imageUrl: 'assets/images/funtastyk young pork tocino 225g.jpg',
                barcode: '7890123453'),
            Product(
                name: 'Bingo Chicken Nuggets 200g',
                description: 'Bingo Chicken Nuggets 200g',
                price: 50.00,
                imageUrl: 'assets/images/bingo chicken nuggets 200g.jpg',
                barcode: '7890123454'),
          ];
        } else if (subcategory == 'Canned Goods') {
          return [
            Product(
                name: 'Youngs Town Sardines Regular 155g',
                description: 'Youngs Town Premium Sardines Regular 155g',
                price: 25.00,
                imageUrl: 'assets/images/youngs town sardines regular 155g.jpg',
                barcode: '8901234561'),
            Product(
                name: 'Century Tuna Flakes in Oil 155g',
                description: 'Century Tuna Flakes in Oil 155g ',
                price: 28.00,
                imageUrl: 'assets/images/century tuna flakes in oil 155g.jpg',
                barcode: '8901234562'),
            Product(
                name: 'Fresca Tuna Afritada 175g',
                description: 'Fresca Tuna Flakes Afritada 175g ',
                price: 20.00,
                imageUrl: 'assets/images/fresca tuna afritada 175g.jpg',
                barcode: '8901234563'),
            Product(
                name: 'Argentina Corned Beef 150g',
                description: 'Argentina Corned Beef 150g',
                price: 35.00,
                imageUrl: 'assets/images/argentina corned beef 150g.jpg',
                barcode: '8901234564'),
            Product(
                name: 'King Cup Sardines 155g',
                description: 'King Cup Sardine 155g',
                price: 20.00,
                imageUrl: 'assets/images/king cup sardines 155g.jpg',
                barcode: '4800193101135'),
            Product(
                name: '555 Sardines 155g',
                description: '555 Sardines 155g',
                price: 22.00,
                imageUrl: 'assets/images/555 sardines 155g.jpg',
                barcode: '748485200019'),
            Product(
                name: 'San Marino Corned Tuna 150g',
                description: 'San Marino Corned Tuna 150g',
                price: 35.00,
                imageUrl: 'assets/images/san marino corned tuna 150g.jpg',
                barcode: '8901234565'),
            Product(
                name: 'WOW Ulam Asado 155g',
                description: 'WOW Ulam Asado 155g',
                price: 25.00,
                imageUrl: 'assets/images/wow ulam asado 155g.jpg',
                barcode: '8901234566'),
            Product(
                name: 'Mega Sardines Tomato Sauce 155g',
                description: 'Mega Sardines Tomato Sauce 155g',
                price: 25.00,
                imageUrl: 'assets/images/mega sardines tomato sauce 155g.jpg',
                barcode: '8901234567'),
          ];
        }

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
        child: Column(
          children: [
            Expanded(
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
                          'assets/images/${product.name.toLowerCase()}.jpg',
                          fit: BoxFit.cover,
                        ),
                        footer: GridTileBar(
                          backgroundColor: Color(0xFF31434F).withOpacity(0.5),
                          title: Text(product.name),
                          subtitle:
                              Text('\₱${product.price.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
