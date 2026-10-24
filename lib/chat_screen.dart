import 'package:flutter/material.dart';
import 'common.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          _statusBar(),
          _header(),
          _itemBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _todayDivider(),
                  const SizedBox(height: 14),
                  _bubble('Hi! Is the fading on both elbows, or mainly the left one?',
                      out: true),
                  _meta('10:12', out: true, read: true),
                  _bubble(
                      'Hi Maya! Mostly the left elbow. I just added a close-up photo so you can see it clearly 😊'),
                  _meta('10:14'),
                  _bubble('Thank you! Any odor or repairs I should know about?',
                      out: true),
                  _meta('10:16', out: true, read: true),
                  _bubble(
                      "No odor and no repairs. It's freshly washed. The cuff thread pull is the only other minus note."),
                  _meta('10:18'),
                  const SizedBox(height: 6),
                  _offerCard(),
                ],
              ),
            ),
          ),
          _composer(),
        ],
      ),
    );
  }

  Widget _statusBar() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 12, 18, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:41',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
          Row(children: [
            Icon(Icons.signal_cellular_alt, size: 11),
            SizedBox(width: 3),
            Icon(Icons.wifi, size: 11),
            SizedBox(width: 3),
            Icon(Icons.battery_full, size: 11),
          ]),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          const Icon(Icons.chevron_left, size: 18),
          const SizedBox(width: 6),
          const AssetPic(path: 'assets/nara.png', width: 28, height: 28, radius: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nara's Closet",
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                const SizedBox(height: 1),
                Row(children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  const Text('Online • replies fast',
                      style: TextStyle(fontSize: 8, color: AppColors.muted)),
                ]),
              ],
            ),
          ),
          const Icon(Icons.phone_outlined, size: 14),
          const SizedBox(width: 12),
          const Icon(Icons.more_vert, size: 14),
        ],
      ),
    );
  }

  Widget _itemBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.line),
          bottom: BorderSide(color: AppColors.line),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          const AssetPic(
              path: 'assets/jaket.png',
              width: 32,
              height: 32,
              radius: 6,
              fallback: Color(0xFF4F5E37)),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DISCUSSING THIS ITEM',
                    style: TextStyle(
                        fontSize: 6.5,
                        letterSpacing: 0.6,
                        color: AppColors.muted)),
                SizedBox(height: 1),
                Text('Olive Linen Work Jacket',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                SizedBox(height: 1),
                Text('Rp 185.000 • 90% Good',
                    style: TextStyle(fontSize: 8.5, color: Color(0xFF555555))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 14, color: AppColors.muted),
        ],
      ),
    );
  }

  Widget _todayDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.line, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('TODAY',
              style: TextStyle(
                  fontSize: 6.5, letterSpacing: 0.8, color: AppColors.muted)),
        ),
        Expanded(child: Divider(color: AppColors.line, height: 1)),
      ],
    );
  }

  Widget _bubble(String text, {bool out = false}) {
    const r = Radius.circular(14);
    const small = Radius.circular(3);
    return Align(
      alignment: out ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 205),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: out ? AppColors.green : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: r,
              topRight: r,
              bottomLeft: out ? r : small,
              bottomRight: out ? small : r,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 9.5,
              height: 1.4,
              color: out ? Colors.white : AppColors.text,
            ),
          ),
        ),
      ),
    );
  }

  Widget _meta(String time, {bool out = false, bool read = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 10),
      child: Align(
        alignment: out ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(time,
                style: const TextStyle(fontSize: 6.5, color: AppColors.muted)),
            if (read) ...[
              const SizedBox(width: 4),
              const Text('Read',
                  style: TextStyle(
                      fontSize: 6.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _offerCard() {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.greenSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('YOUR OFFER',
                  style: TextStyle(
                      fontSize: 6.5,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green)),
              Icon(Icons.sell_outlined, size: 10, color: AppColors.green),
            ],
          ),
          SizedBox(height: 6),
          Text('Rp 170.000',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          SizedBox(height: 2),
          Text('Waiting for seller response',
              style: TextStyle(fontSize: 7.5, color: Color(0xFF6B7360))),
        ],
      ),
    );
  }

  Widget _composer() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 26),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
                color: AppColors.greenSoft, shape: BoxShape.circle),
            child: const Icon(Icons.add, size: 14, color: AppColors.green),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEBE7DA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Message Nara...',
                      style: TextStyle(fontSize: 9, color: AppColors.muted)),
                  Icon(Icons.sentiment_satisfied_alt_outlined,
                      size: 12, color: AppColors.muted),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
                color: AppColors.green, shape: BoxShape.circle),
            child: const Icon(Icons.send_outlined, size: 13, color: Colors.white),
          ),
        ],
      ),
    );
  }
}