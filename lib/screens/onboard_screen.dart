import 'package:ezcheck_app/screens/onboard1_screen.dart';
import 'package:flutter/material.dart';

class LoginScreenCheck extends StatelessWidget {
  const LoginScreenCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: OnbordingScreen(),
    );
  }
}