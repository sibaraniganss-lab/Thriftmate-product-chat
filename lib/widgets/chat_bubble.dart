import 'package:flutter/material.dart';

// REUSABLE WIDGET 2: bubble chat. Dipakai 4x di halaman chat.
// isMe = true -> bubble pembeli (hijau tua), false -> bubble penjual (putih).
class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isMe ? cs.primary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isMe
                  ? null
                  : const [
                      BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
                    ],
            ),
            child: Text(
              message,
              style: tt.bodyMedium?.copyWith(color: isMe ? cs.onPrimary : cs.onSurface),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isMe ? '$time  Read' : time,
            style: tt.labelSmall?.copyWith(color: cs.outline),
          ),
        ],
      ),
    );
  }
}