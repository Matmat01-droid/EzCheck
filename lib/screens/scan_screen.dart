import 'package:ezcheck_app/main.dart';
import 'package:ezcheck_app/models/products.dart';
import 'package:ezcheck_app/providers/barcode_provider.dart';
import 'package:ezcheck_app/screens/product_details_screen.dart';
import 'package:ezcheck_app/screens/scan_product_detail.dart';
import 'package:ezcheck_app/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late Future<void> _scanBarcodeFuture = Future.value(); // Initialize here
  TextEditingController _barcodeController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Product> getSampleProducts() {
    return [
      Product(
          name: 'Milo',
          description: 'Nestle Milo 35g',
          price: 8.00,
          imageUrl: 'assets/images/milo.jpg',
          barcode: '1234567890'),
      Product(
          name: 'Bear Brand',
          description: 'Nestle Bear Brand 320g + 30g',
          price: 50.00,
          imageUrl: 'assets/images/bear brand.jpg',
          barcode: '1234567891'),
      Product(
          name: 'Birch Tree',
          description: 'Birch Tree Fortified 150g',
          price: 9.00,
          imageUrl: 'assets/images/birch tree.jpg',
          barcode: '1234567892'),
      Product(
          name: 'Kopiko',
          description: 'Kopiko Black 3 In One Coffee 25g',
          price: 9.00,
          imageUrl: 'assets/images/kopiko.jpg',
          barcode: '1234567893'),
      Product(
          name: 'Great Taste',
          description: 'Great Taste White Caramel Sachet 30g',
          price: 9.00,
          imageUrl: 'assets/images/great taste.jpg',
          barcode: '1234567894'),
      Product(
          name: 'Energen',
          description: 'Energen Chocolate Cereal 30g',
          price: 8.00,
          imageUrl: 'assets/images/energen.jpg',
          barcode: '1234567895'),
      Product(
          name: 'Tang',
          description: 'Tang Pineapple Instant Drink Mix 25g',
          price: 18.00,
          imageUrl: 'assets/images/tang.jpg',
          barcode: '1234567896'),
      Product(
          name: 'Coca-Cola',
          description: 'Coca-Cola 1L',
          price: 65.00,
          imageUrl: 'assets/images/coca-cola.jpg',
          barcode: '2345678901'),
      Product(
          name: 'Pepsi',
          description: 'Pepsi Cola 1L',
          price: 65.00,
          imageUrl: 'assets/images/pepsi.jpg',
          barcode: '2345678902'),
      Product(
          name: 'Sprite',
          description: 'Sprite 1L',
          price: 65.00,
          imageUrl: 'assets/images/sprite.jpg',
          barcode: '2345678903'),
      Product(
          name: 'Royal',
          description: 'Royal 1.5L',
          price: 70.00,
          imageUrl: 'assets/images/royal.jpg',
          barcode: '2345678904'),
      Product(
          name: 'Mountain Dew',
          description: 'B&M Mountain Dew Energy 1L',
          price: 70.00,
          imageUrl: 'assets/images/mountain dew.jpg',
          barcode: '2345678905'),
      Product(
          name: 'Mirinda',
          description: 'Mirinda Orange 1L',
          price: 70.00,
          imageUrl: 'assets/images/mirinda.jpg',
          barcode: '2345678906'),
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
      Product(
          name: 'Tide',
          description: 'Tide Powder Detergent with Downy 720g',
          price: 50.00,
          imageUrl: 'assets/images/tide.jpg',
          barcode: '4567890121'),
      Product(
          name: 'Pride',
          description: 'Pride Powder Detergent AntiBac 500g',
          price: 6.00,
          imageUrl: 'assets/images/pride.jpg',
          barcode: '4567890122'),
      Product(
          name: 'Ariel',
          description: 'Ariel Powder 1 KG',
          price: 250.00,
          imageUrl: 'assets/images/ariel.jpg',
          barcode: '4567890123'),
      Product(
          name: 'Surf',
          description: 'Surf Powder Rose Fresh 70g',
          price: 6.00,
          imageUrl: 'assets/images/surf.jpg',
          barcode: '4567890124'),
      Product(
          name: 'Calla',
          description: 'Calla Detergent Powder w/ Fabcon Rose Garden 100g',
          price: 4.99,
          imageUrl: 'assets/images/calla.jpg',
          barcode: '4567890125'),
      Product(
          name: 'Piattos',
          description: 'JACK N JILL PIATTOS CHEESE 85g',
          price: 25.00,
          imageUrl: 'assets/images/piattos.jpg',
          barcode: '5678901231'),
      Product(
          name: 'Nova',
          description:
              'NOVA MULTI-GRAIN SNACKS (Country Cheddar Flavor) 40 grams',
          price: 14.00,
          imageUrl: 'assets/images/nova.jpg',
          barcode: '5678901232'),
      Product(
          name: 'Chippy',
          description: 'Chippy BBQ 110g',
          price: 24.00,
          imageUrl: 'assets/images/chippy.jpg',
          barcode: '5678901233'),
      Product(
          name: 'Clover',
          description: 'Clover Chips Cheese 26G',
          price: 7.00,
          imageUrl: 'assets/images/clover.jpg',
          barcode: '5678901234'),
      Product(
          name: 'Goya',
          description: 'Goya Milk Chocolate 35G',
          price: 12.00,
          imageUrl: 'assets/images/goya.jpg',
          barcode: '6789012341'),
      Product(
          name: 'Flat Tops',
          description: 'Flat Tops Milk Chocolate 150g',
          price: 20.00,
          imageUrl: 'assets/images/flat tops.jpg',
          barcode: '6789012342'),
      Product(
          name: 'Choco Mucho',
          description: 'Choco Mucho Choco 32g',
          price: 8.00,
          imageUrl: 'assets/images/choco mucho.jpg',
          barcode: '6789012343'),
      Product(
          name: 'Beng Beng',
          description: 'Beng-Beng Chocolate 32g',
          price: 7.00,
          imageUrl: 'assets/images/beng beng.jpg',
          barcode: '6789012344'),
      Product(
          name: 'Cream O',
          description: 'Cream-O Vanilla/Chocolate Sandwich Cookies 10pcs',
          price: 60.00,
          imageUrl: 'assets/images/cream o.jpg',
          barcode: '6789012345'),
      Product(
          name: 'Tender Juicy',
          description: 'Purefoods Tender Juicy Jumbo 1kg',
          price: 150.00,
          imageUrl: 'assets/images/tender juicy.jpg',
          barcode: '7890123451'),
      Product(
          name: 'Idol',
          description: 'Cdo Idol Cheesedog Regular 1KG',
          price: 150.00,
          imageUrl: 'assets/images/idol.jpg',
          barcode: '7890123452'),
      Product(
          name: 'Funtastyk',
          description: 'Funtastyk Young Pork Tocino Flat-Pack 225G',
          price: 60.00,
          imageUrl: 'assets/images/funtastyk.jpg',
          barcode: '7890123453'),
      Product(
          name: 'Bingo',
          description: 'Bingo Chicken Nuggets 200g',
          price: 50.00,
          imageUrl: 'assets/images/bingo.jpg',
          barcode: '7890123454'),
      Product(
          name: 'Youngs Town',
          description: 'Youngs Town Premium Sardines Regular 155g',
          price: 25.00,
          imageUrl: 'assets/images/youngs town.jpg',
          barcode: '8901234561'),
      Product(
          name: 'Century Tuna',
          description: 'Century Tuna Flakes in Oil 155g ',
          price: 28.00,
          imageUrl: 'assets/images/century tuna.jpg',
          barcode: '8901234562'),
      Product(
          name: 'Fresca Tuna',
          description: 'Fresca Tuna Flakes Afritada 175g ',
          price: 20.00,
          imageUrl: 'assets/images/fresca tuna.jpg',
          barcode: '8901234563'),
      Product(
          name: 'Argentina',
          description: 'Argentina Corned Beef 150g',
          price: 35.00,
          imageUrl: 'assets/images/argentina.jpg',
          barcode: '8901234564'),
      Product(
          name: 'King Cup',
          description: 'King Cup Sardine 155g',
          price: 20.00,
          imageUrl: 'assets/images/king cup.jpg',
          barcode: '4800193101135'),
      Product(
          name: '555 Sardines',
          description: '555 Sardines 155g',
          price: 22.00,
          imageUrl: 'assets/images/555 sardines.jpg',
          barcode: '748485200019'),
    ];
  }

  bool _areBarcodesEqual(String barcode1, String barcode2) {
    String cleanedBarcode1 = _cleanBarcode(barcode1);
    String cleanedBarcode2 = _cleanBarcode(barcode2);

    print('Entered Barcode: $cleanedBarcode1');
    print('Product Barcode: $cleanedBarcode2');

    bool result = cleanedBarcode1 == cleanedBarcode2;
    print('Are Barcodes Equal? $result');

    return result;
  }

  void _startBarcodeScanning() {
    setState(() {
      // Access barcode through the context parameter
      Provider.of<BarcodeProvider>(context, listen: false)
          .scanBarcodeNormal()
          .then((_) {
        // Check if the scanned barcode is in the product list
        String scannedBarcode =
            Provider.of<BarcodeProvider>(context, listen: false).barcodeScanRes;
        Product? foundProduct = getProductByBarcode(scannedBarcode);

        if (foundProduct != null &&
            _areBarcodesEqual(foundProduct.barcode, scannedBarcode)) {
          // Product found, navigate to details screen
          navigateToProductDetails(foundProduct);
        } else {
          // Product not found or barcode does not match, show the "Product Not Available" dialog
          showProductNotAvailableDialog(context);
        }
      });

      _barcodeController.text = ''; // Clear the previous barcode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BarcodeProvider>(builder: (context, barcode, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFF31434F),
          title: const Text("Barcode & QRcode Scanner"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _startBarcodeScanning,
          label: Row(
            children: const [
              Icon(Icons.qr_code_scanner),
              SizedBox(width: 6),
              Text(
                "Scan Products",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          backgroundColor: Color(0xFF31434F),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: const Text(
                  "Scanned Code",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                constraints: BoxConstraints(minHeight: 108),
                alignment: Alignment.center,
                margin: const EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primary),
                ),
                child: FutureBuilder<void>(
                  future: _scanBarcodeFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // Handle error during scanning
                        return Text("Error: ${snapshot.error}");
                      }
                      // Scanning is complete, update the controller with the barcode
                      _barcodeController.text = barcode.barcodeScanRes;
                      return TextField(
                        controller: _barcodeController,
                        style: const TextStyle(fontSize: 16),
                        readOnly: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      // Scanning is in progress, show a loading indicator
                      return CircularProgressIndicator();
                    } else {
                      // Handle other connection states if needed
                      return Text('Scan in progress...');
                    }
                  },
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF31434F),
                  ),
                  onPressed: () {
                    // Check if the scanned or manually entered barcode is in the product list
                    String enteredBarcode = _barcodeController.text;
                    Product? foundProduct = getProductByBarcode(enteredBarcode);

                    if (foundProduct != null &&
                        _areBarcodesEqual(
                            foundProduct.barcode, enteredBarcode)) {
                      // Product found, navigate to details screen
                      navigateToProductDetails(foundProduct);
                    } else {
                      // Product not found or barcode does not match, show the "Product Not Available" dialog
                      showProductNotAvailableDialog(context);
                    }
                  },
                  child: Text("View Product Details"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void navigateToProductDetails(Product foundProduct) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: foundProduct),
      ),
    );
  }

  Product? getProductByBarcode(String barcode) {
    List<Product> allProducts = getSampleProducts();
    try {
      Product foundProduct = allProducts.firstWhere(
        (product) {
          print('Product Barcode: ${_cleanBarcode(product.barcode)}');
          print('Entered Barcode: ${_cleanBarcode(barcode)}');
          return _cleanBarcode(product.barcode) == _cleanBarcode(barcode);
        },
      );

      print('Found Product: ${foundProduct.name}');
      return foundProduct;
    } catch (e) {
      // Handle the case where the product is not found
      return null;
    }
  }

  void showProductNotAvailableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Product Barcode Does Not Exist'),
          content: Text('The entered product barcode is not available.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _cleanBarcode(String barcode) {
    return barcode.trim().toLowerCase().replaceAll(RegExp(r'[^0-9]'), '');
  }
}
