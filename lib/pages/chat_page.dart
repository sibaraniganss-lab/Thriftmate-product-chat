import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/circle_icon_button.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://picsum.photos/201'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nara's Closet",
                    style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Color(0xFF4C9A5B)),
                    const SizedBox(width: 4),
                    Text('Online • replies fast',
                        style: tt.labelSmall?.copyWith(color: cs.outline)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.phone_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _productBanner(cs, tt),
          const Expanded(
            child: _MessageList(),
          ),
          _inputBar(context, cs),
        ],
      ),
    );
  }

  // Banner produk yang sedang dibahas
  Widget _productBanner(ColorScheme cs, TextTheme tt) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://picsum.photos/100/100',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 48,
                height: 48,
                color: cs.primaryContainer,
                child: Icon(Icons.checkroom, color: cs.primary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DISCUSSING THIS ITEM',
                    style: tt.labelSmall?.copyWith(color: cs.outline, letterSpacing: 0.8)),
                Text('Olive Linen Work Jacket',
                    style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                RichText(
                  text: TextSpan(
                    style: tt.bodySmall?.copyWith(color: cs.onSurface),
                    children: const [
                      TextSpan(text: 'Rp 185.000', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' • 90% Good'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: cs.outline),
        ],
      ),
    );
  }

  Widget _inputBar(BuildContext context, ColorScheme cs) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            CircleIconButton(
              icon: Icons.add,
              size: 44,
              background: cs.primaryContainer,
              iconColor: cs.primary,
              bordered: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Message Nara...',
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  suffixIcon: const Icon(Icons.sentiment_satisfied_alt_outlined),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            CircleIconButton(
              icon: Icons.send_outlined,
              size: 48,
              background: cs.primary,
              iconColor: cs.onPrimary,
              bordered: false,
            ),
          ],
        ),
      ),
    );
  }
}

// Daftar pesan (sesuai desain Figma)
class _MessageList extends StatelessWidget {
  const _MessageList();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('TODAY',
                  style: tt.labelSmall?.copyWith(color: cs.outline, letterSpacing: 1)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 8),
        const ChatBubble(
          message: 'Hi! Is the fading on both elbows, or mainly the left one?',
          time: '10:12',
          isMe: true,
        ),
        const ChatBubble(
          message:
              'Hi Maya! Mostly the left elbow. I just added a close-up photo so you can see it clearly 😊',
          time: '10:14',
        ),
        const ChatBubble(
          message: 'Thank you! Any odor or repairs I should know about?',
          time: '10:16',
          isMe: true,
        ),
        const ChatBubble(
          message:
              "No odor and no repairs. It's freshly washed. The cuff thread pull is the only other minus note.",
          time: '10:18',
        ),
        const SizedBox(height: 8),
        // Kartu penawaran
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 210,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('YOUR OFFER',
                        style: tt.labelSmall?.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5)),
                    Icon(Icons.sell_outlined, size: 16, color: cs.primary),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Rp 170.000',
                    style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('Waiting for seller response',
                    style: tt.bodySmall?.copyWith(color: cs.outline)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}