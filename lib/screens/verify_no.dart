import 'package:ezcheck_app/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPFormPage extends StatelessWidget {
  const OTPFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 60,
        textStyle: TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
        ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF31434F),
        title: Text('OTP Number'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                'Verification',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 48),
                child: const Text(
                  'Enter the code number sent to your number',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 48),
                child: const Text(
                  '+639 123-456 7890',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
                onCompleted: (pin) => debugPrint(pin),
              ),
              SizedBox(height: 80),
              Container(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF31434F)),
                    onPressed: () {
                      //function
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreenCheck(),
                        ),
                      );
                    },
                    child: Text('Continue')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
