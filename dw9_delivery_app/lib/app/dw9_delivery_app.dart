import 'package:flutter/material.dart';

import 'pages/splash/splash_page.dart';

class Dw9DeliveryApp extends StatelessWidget {
  const Dw9DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
