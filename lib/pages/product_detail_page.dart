import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import '../widgets/circle_icon_button.dart';
import 'chat_page.dart';

// StatefulWidget: dibutuhkan karena ada yang berubah saat disentuh
// (tombol favorit, slide foto, dan penanda 1/4).
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();
  int _page = 0;
  bool _isFavorite = false;

  final List<String> _images = const [
    'assets/images/jaket.png',
    'assets/images/jaket_2.png',
    'assets/images/jaket_3.png',
    'assets/images/jaket_4.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openChat() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatPage()));
  }

  // Tombol tag: buka form tawar harga (bukan pindah ke chat)
  Future<void> _makeOffer() async {
    final value = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _OfferSheet(),
    );
    if (value != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Offer ${_rupiah(value)} sent to Nara's Closet")),
      );
    }
  }

  String _rupiah(int v) {
    final s = v.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
      b.write(s[i]);
    }
    return 'Rp $b';
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
        title: Text('Item Details',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: CircleIconButton(
                icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                iconColor: _isFavorite ? Colors.red : null,
                onTap: () => setState(() => _isFavorite = !_isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _photo(cs, tt),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: tt.labelLarge?.copyWith(color: cs.outline, letterSpacing: 0.5),
                    children: const [
                      TextSpan(text: 'MUJI • M'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('90% Good',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Olive Linen Work Jacket',
                style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('Rp 185.000',
                style: tt.titleLarge?.copyWith(color: cs.primary, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            _flawsCard(cs, tt),
            const SizedBox(height: 16),
            _sellerCard(cs, tt),
          ],
        ),
      ),
      // Visual hierarchy: Buy Now = primary (filled), tag = secondary (outlined)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: cs.outlineVariant)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              OutlinedButton(
                onPressed: _makeOffer,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(56, 56),
                  padding: EdgeInsets.zero,
                  side: BorderSide(color: cs.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Icon(Icons.sell_outlined),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Olive Linen Work Jacket dibeli!')),
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('Buy Now • Rp 185k',
                      style: tt.titleMedium?.copyWith(
                          color: cs.onPrimary, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Foto produk yang bisa di-slide + penanda "1 / 4" + titik indikator
  Widget _photo(ColorScheme cs, TextTheme tt) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 293 / 239,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // dragDevices ditambah mouse supaya bisa di-slide di Chrome
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => Image.asset(
                  _images[i],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: cs.primaryContainer,
                    child: Icon(Icons.checkroom, size: 96, color: cs.primary),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.photo_outlined, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text('${_page + 1} / ${_images.length}',
                          style: tt.labelSmall?.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (i) => _dot(i == _page)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _flawsCard(ColorScheme cs, TextTheme tt) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.tertiary.withAlpha(90)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, size: 20, color: cs.tertiary),
              const SizedBox(width: 8),
              Text('Flaws/Minus Notes',
                  style: tt.titleSmall?.copyWith(
                      color: cs.tertiary, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Tiny thread pull near the left cuff and light fading at the elbows. '
            'No stains, odors, or missing buttons.',
            style: tt.bodyMedium?.copyWith(color: cs.onTertiaryContainer),
          ),
        ],
      ),
    );
  }

  Widget _sellerCard(ColorScheme cs, TextTheme tt) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: cs.primaryContainer,
            backgroundImage: const AssetImage('assets/images/nara.png'),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nara's Closet",
                    style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: tt.bodySmall?.copyWith(color: cs.outline),
                    children: const [
                      TextSpan(text: '★ 4.9 • 128 sold • Replies in 5m'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tombol chat -> pindah ke halaman Buyer Seller Chat
          CircleIconButton(
            icon: Icons.chat_bubble_outline,
            background: cs.primaryContainer,
            iconColor: cs.primary,
            bordered: false,
            onTap: _openChat,
          ),
        ],
      ),
    );
  }
}

// Form tawar harga (bottom sheet)
class _OfferSheet extends StatefulWidget {
  const _OfferSheet();

  @override
  State<_OfferSheet> createState() => _OfferSheetState();
}

class _OfferSheetState extends State<_OfferSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = int.tryParse(_controller.text.replaceAll('.', '').trim());
    if (value != null && value > 0) Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 24, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Make an offer',
              style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('Listing price: Rp 185.000',
              style: tt.bodyMedium?.copyWith(color: cs.outline)),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              prefixText: 'Rp ',
              hintText: '170000',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Send offer'),
          ),
        ],
      ),
    );
  }
}