import 'package:flutter/material.dart';
import 'screens/cat_card_screen.dart';

void main() {
  runApp(const CatTinderApp());
}

class CatTinderApp extends StatelessWidget {
  const CatTinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KotoTinder',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CatCardScreen(),
    );
  }
}
