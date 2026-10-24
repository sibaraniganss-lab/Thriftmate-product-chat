import 'package:flutter/material.dart';
import 'pages/product_detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThriftMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Material 3 (M01 & M04)
        // Warna dibuat dari seed, lalu role tertentu disesuaikan dengan desain Figma
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F4A33)).copyWith(
          primary: const Color(0xFF2F4A33),
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFDDE5D3),
          onPrimaryContainer: const Color(0xFF2F4A33),
          tertiary: const Color(0xFFB5552B),
          tertiaryContainer: const Color(0xFFF9E8DC),
          onTertiaryContainer: const Color(0xFF4A2210),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F4EC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F4EC),
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
      ),
      home: const ProductDetailPage(),
    );
  }
}