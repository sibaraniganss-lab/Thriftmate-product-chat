import 'package:flutter/material.dart';

// REUSABLE WIDGET 3: kartu notifikasi. Dipakai 5x di halaman Notifications.
// isUnread = true -> kartu putih + titik hijau; false -> kartu transparan (warna halaman) tanpa titik.
class NotificationCard extends StatelessWidget {
  final IconData icon;
  final bool peach; // true = ikon bertema oranye (misal: turun harga)
  final String title;
  final String body;
  final String time;
  final String actionLabel;
  final bool isUnread;
  final VoidCallback? onTap;
  final VoidCallback? onAction;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
    required this.actionLabel,
    this.peach = false,
    this.isUnread = false,
    this.onTap,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: peach ? cs.tertiaryContainer : cs.primaryContainer,
                  ),
                  child: Icon(icon, size: 18, color: peach ? cs.tertiary : cs.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: tt.titleSmall?.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF3B6B45),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        body,
                        style: tt.bodyMedium?.copyWith(
                            fontSize: 13, height: 1.4, color: cs.outline),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(time,
                              style: tt.labelSmall
                                  ?.copyWith(fontSize: 11, color: cs.outline)),
                          InkWell(
                            onTap: onAction,
                            child: Text(
                              '$actionLabel →',
                              style: tt.labelLarge?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}