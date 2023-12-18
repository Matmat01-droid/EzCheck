import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
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
            SizedBox(height: 120), // Add space above the image
            Image.asset(
              'assets/images/EzCheckIcon2.png',
              height: 300,
            ),
            SizedBox(height: 20),
            SizedBox(height: 30),
            const Text(
              'Scan the barcode',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              """
You can scan the barcode on the product to
update it in the cart.
""",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
