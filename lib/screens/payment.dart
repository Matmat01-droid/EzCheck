import 'package:ezcheck_app/screens/history_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  PaymentScreen({required this.totalAmount, required this.cartItems});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color(0xFF31434F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Amount: ₱${widget.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.cartItems.map((item) {
                    double totalPrice =
                        item['quantity'] * (item['price'] ?? 0.0);
                    return ListTile(
                      title: Text('Product: ${item['productName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${item['quantity']}'),
                          Text(
                              'Total Price: ₱${totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Payment Options',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    PaymentOptionTile(
                      icon: Icons.store,
                      title: 'Pay in Counter',
                      value: 0,
                      groupValue: selectedPaymentOption,
                      onChanged: (value) {
                        updateSelectedPaymentOption(value);
                      },
                    ),
                    PaymentOptionTile(
                      icon: Icons.mobile_screen_share,
                      title: 'Through Mobile Wallet',
                      value: 1,
                      groupValue: selectedPaymentOption,
                      onChanged: (value) {
                        updateSelectedPaymentOption(value);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showPaymentConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF31434F),
                      ),
                      child: Text('Proceed to Payment'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateSelectedPaymentOption(int? value) {
    setState(() {
      selectedPaymentOption = value;
    });
  }

  void showPaymentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text('Are you sure you want to proceed with the payment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
                showPaymentSuccessDialog(context);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Thank you for your purchase!'),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF31434F),
                ),
                onPressed: () {
                  moveToHistoryScreen(context); // Ensure passing the context
                },
                child: Text('View Purchase History'),
              ),
            ],
          ),
        );
      },
    );
  }

  void moveToHistoryScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          totalAmount: widget.totalAmount,
          cartItems: widget.cartItems,
        ),
      ),
    );
  }
}

class PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final int value;
  final int? groupValue;
  final Function(int?) onChanged;

  const PaymentOptionTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio<int>(
        value: value,
        groupValue: groupValue,
        onChanged: (int? value) {
          onChanged(value);
        },
      ),
      title: Text(title),
    );
  }
}
