import 'package:ezcheck_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SplashScreenCheck());
}

class SplashScreenCheck extends StatefulWidget {
  const SplashScreenCheck({super.key});

  @override
  State<SplashScreenCheck> createState() => _SplashScreenCheckState();
}

class _SplashScreenCheckState extends State<SplashScreenCheck>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF31434F), Color(0xFF74A5A9)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/EzCheckLogo.png'),
            SizedBox(height: 20),
            Image.asset('assets/images/EzCheckText.png'),
          ],
        ),
      ),
    );
  }
}
