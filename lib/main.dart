import 'package:ezcheck_app/providers/all_providers.dart';
import 'package:ezcheck_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(MultiProvider(providers: providersAll, child: const EzCheckScreen(),));
}

class EzCheckScreen extends StatelessWidget {
  const EzCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenCheck(),
    );
  }
}

MaterialColor primary = Colors.indigo;
