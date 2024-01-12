import 'package:ezcheck_app/main.dart';
import 'package:ezcheck_app/providers/barcode_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<BarcodeProvider>(builder: (context, barcode, child) {
      return Scaffold(
        key: mainKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFF31434F),
          title: const Text("Barcode & QRcode Scanner"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              // Reset the future to trigger a new scan
              _scanBarcodeFuture = barcode.scanBarcodeNormal();
            });
          },
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
                      // Scanning is complete, display the barcode
                      return TextField(
                        controller:
                            TextEditingController(text: barcode.barcodeScanRes),
                        style: const TextStyle(fontSize: 16),
                        readOnly: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Handle error during scanning
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // Scanning is in progress, show a loading indicator
                      return CircularProgressIndicator();
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
                    // Implement the logic for manual scanning
                    // You can open a dialog or navigate to a manual scanning screen
                  },
                  child: Text("View All Products"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void navigateToProductDetails(String barcode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannedProductDetailsScreen(barcode: barcode),
      ),
    );
  }
}
