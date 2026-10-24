import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFFF5F2EA);
  static const green = Color(0xFF2F4234);
  static const greenSoft = Color(0xFFDFE6D6);
  static const muted = Color(0xFF8A877D);
  static const line = Color(0xFFE6E1D4);
  static const text = Color(0xFF1F1F1C);
  static const warnBg = Color(0xFFF6E9DC);
  static const warnLine = Color(0xFFECD5BD);
  static const warn = Color(0xFFA5532A);
}

/// Status bar tiruan (9:41) supaya mirip desain.
class FakeStatusBar extends StatelessWidget {
  const FakeStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:41',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          Row(children: [
            Icon(Icons.signal_cellular_alt, size: 14),
            SizedBox(width: 4),
            Icon(Icons.wifi, size: 14),
            SizedBox(width: 4),
            Icon(Icons.battery_full, size: 14),
          ]),
        ],
      ),
    );
  }
}

/// Gambar dari assets. Kalau file belum ada, tampil warna polos (tidak error).
class AssetPic extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final double radius;
  final Color fallback;

  const AssetPic({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.radius = 0,
    this.fallback = const Color(0xFFB98466),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(color: fallback),
        ),
      ),
    );
  }
}