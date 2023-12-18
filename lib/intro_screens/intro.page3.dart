import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align content at the top
          children: [
            SizedBox(height: 100), // Add space above the image
            Image.asset(
              'assets/images/EzCheckIcon3.png',
              height: 300,
            ),
            SizedBox(height: 20),
            SizedBox(height: 30),
            const Text(
              'Start Shopping',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 36,
              ),
            ),
            SizedBox(height: 20),
            Text(
              """
Scan the barcode which is in the product, it will be updated in your cart and you can check to your cart to see whether you bought everything.
""",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
