import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
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
              'assets/images/EzCheckIcon1.png',
              height: 300,
            ),
            SizedBox(height: 20),
            SizedBox(height: 30),
            const Text(
              'Self - checkout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 36,
              ),
            ),
            SizedBox(height: 20),
            Text(
              """
Now shop at your own pace. Save time without standing in the queue for a long time to get your things packed and billed
""",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
