import 'package:flutter/material.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/notification_card.dart';
import 'chat_page.dart';

// Data satu notifikasi (read bisa berubah saat kartu disentuh)
class _Notif {
  final IconData icon;
  final bool peach;
  final String title;
  final String body;
  final String time;
  final String action;
  final bool today;
  final bool opensChat;
  bool read;

  _Notif({
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
    required this.action,
    required this.today,
    this.peach = false,
    this.opensChat = false,
    this.read = false,
  });
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<_Notif> _items = [
    _Notif(
      icon: Icons.local_shipping_outlined,
      title: 'Your piece is on its way!',
      body: 'Olive Linen Work Jacket is in transit with J&T. Estimated arrival Oct 3–4.',
      time: '5 min ago',
      action: 'Track order',
      today: true,
    ),
    _Notif(
      icon: Icons.chat_bubble_outline,
      title: "New message from Nara's Closet",
      body: '"Hi Maya! I\'ve added a close-up photo so you can see it clearly."',
      time: '12 min ago',
      action: 'Reply',
      today: true,
      opensChat: true,
    ),
    _Notif(
      icon: Icons.trending_down,
      peach: true,
      title: 'A favorite, for a little less',
      body: 'Canvas City Tote dropped from Rp 110k to Rp 95k. Still looking for a new home.',
      time: '1 hr ago',
      action: 'View item',
      today: true,
    ),
    _Notif(
      icon: Icons.check_circle_outline,
      title: 'Payment received',
      body: 'Rp 203.000 paid for order #TM10281. Your payment is safely held until delivery.',
      time: 'Oct 1 • 10:20',
      action: 'View receipt',
      today: false,
      read: true,
    ),
    _Notif(
      icon: Icons.eco_outlined,
      title: 'Small choices. Bigger change.',
      body: 'Join Wear the Change: give a pre-loved piece its next chapter.',
      time: 'Oct 1 • 09:00',
      action: 'Explore campaign',
      today: false,
      read: true,
    ),
  ];

  int get _unread => _items.where((n) => !n.read).length;

  void _markAllRead() => setState(() {
        for (final n in _items) {
          n.read = true;
        }
      });

  void _action(_Notif n) {
    setState(() => n.read = true);
    if (n.opensChat) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${n.action}...')));
    }
  }

  List<Widget> _section(BuildContext context, String label, bool today) {
    final tt = Theme.of(context).textTheme;
    return [
      Text(label, style: tt.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      for (final n in _items.where((n) => n.today == today)) ...[
        NotificationCard(
          icon: n.icon,
          peach: n.peach,
          title: n.title,
          body: n.body,
          time: n.time,
          actionLabel: n.action,
          isUnread: !n.read,
          onTap: () => setState(() => n.read = true),
          onAction: () => _action(n),
        ),
        const SizedBox(height: 12),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: CircleIconButton(
              icon: Icons.chevron_left,
              onTap: () => Navigator.maybePop(context),
            ),
          ),
        ),
        title: Text('Notifications',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Notification settings'))),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _unread == 0 ? 'All caught up' : '$_unread unread',
                  style: tt.labelMedium?.copyWith(
                      fontSize: 12, color: cs.primary, fontWeight: FontWeight.w700),
                ),
              ),
              InkWell(
                onTap: _unread == 0 ? null : _markAllRead,
                child: Text(
                  'Mark all as read',
                  style: tt.labelLarge?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _unread == 0 ? cs.outline : cs.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._section(context, 'Today', true),
          const SizedBox(height: 4),
          ..._section(context, 'Yesterday', false),
        ],
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

// Navigasi bawah sesuai desain Figma (Profile aktif)
class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: const SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_outlined, label: 'Home'),
              _NavItem(icon: Icons.circle_outlined, label: 'Search'),
              _NavItem(icon: Icons.add_circle_outline, label: 'Sell'),
              _NavItem(icon: Icons.shopping_bag_outlined, label: 'Orders'),
              _NavItem(label: 'Profile', selected: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool selected;
  const _NavItem({this.icon, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          child: Center(
            child: selected
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: cs.primary, width: 1.5),
                    ),
                  )
                : Icon(icon, size: 24, color: cs.outline.withAlpha(160)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: tt.labelSmall?.copyWith(
            color: selected ? cs.primary : cs.outline.withAlpha(160),
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}