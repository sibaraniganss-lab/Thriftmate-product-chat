import 'package:flutter/material.dart';

// REUSABLE WIDGET 1: tombol ikon bulat.
// Dipakai di: tombol back, favorit, chat penjual, tombol +, tombol kirim.
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? background;
  final Color? iconColor;
  final bool bordered;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 40,
    this.background,
    this.iconColor,
    this.bordered = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: background ?? Colors.white,
          border: bordered ? Border.all(color: cs.outlineVariant) : null,
        ),
        child: Icon(icon, size: 20, color: iconColor ?? cs.onSurface),
      ),
    );
  }
}