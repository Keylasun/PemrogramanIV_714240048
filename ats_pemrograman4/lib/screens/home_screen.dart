import 'package:flutter/material.dart';

/// Halaman Home bertema Porsche official website
/// Menerapkan materi layout: Column, Row, Container, Stack,
/// BoxDecoration, SingleChildScrollView, Padding, dll.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ═══ PORSCHE BRAND PALETTE ═══
  static const Color porscheRed = Color(0xFFD5001C);
  static const Color porscheBlack = Color(0xFF111111);
  static const Color porscheDarkGrey = Color(0xFF1A1A1A);
  static const Color porscheGold = Color(0xFFC5A059);
  static const Color porscheSilver = Color(0xFFB0B0B0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ═══ PORSCHE APP BAR ═══
          SliverAppBar(
            expandedHeight: 56,
            floating: true,
            backgroundColor: porscheBlack,
            title: Row(
              children: [
                // Logo text PORSCHE
                const Text(
                  'PORSCHE',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 8),
                // Badge ID
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: porscheRed,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    'ID',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 22),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 22),
                onPressed: () {},
              ),
            ],
          ),

          // ═══ BODY CONTENT ═══
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── 1. HERO BANNER ──
                _buildHeroBanner(),

                // ── 2. KARTU IDENTITAS MAHASISWA (DRIVER PASS) ──
                _buildDriverPass(),

                // ── 3. HIGHLIGHTS SECTION ──
                _buildHighlightsSection(),

                // ── 4. MODEL LINEUP ──
                _buildModelLineup(),

                // ── 5. PORSCHE EXPERIENCE SECTION ──
                _buildExperienceSection(),

                // ── 6. FOOTER ──
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // 1. HERO BANNER — Full-width immersive banner
  // ═══════════════════════════════════════════
  Widget _buildHeroBanner() {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [porscheBlack, Color(0xFF2A2A2A)],
        ),
      ),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1614162692292-7ac56d7f7f1e?q=80&w=1200&auto=format&fit=crop',
              fit: BoxFit.cover,
              color: Colors.black.withAlpha(100),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (_, _, _) => Container(
                color: porscheBlack,
                child: const Center(
                  child: Icon(Icons.directions_car,
                      color: porscheGold, size: 80),
                ),
              ),
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(180),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Red accent line
                Container(width: 50, height: 4, color: porscheRed),
                const SizedBox(height: 14),
                const Text(
                  'THE NEW 911 GT3 RS',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Born from motorsport. Perfected for the road.\nPure driving in its most thrilling form.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // CTA Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: porscheBlack,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'DISCOVER',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Secondary Button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'CONFIGURE',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // 2. DRIVER PASS — Kartu identitas mahasiswa VIP
  // ═══════════════════════════════════════════
  Widget _buildDriverPass() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: porscheDarkGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: porscheGold.withAlpha(120), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header strip
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: porscheRed,
              borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'PORSCHE DRIVER PASS',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
                Icon(Icons.verified, color: Colors.white.withAlpha(200), size: 18),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar circle
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: porscheGold, width: 2),
                        color: porscheBlack,
                      ),
                      child: const Center(
                        child: Text(
                          'KS',
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            color: porscheGold,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Name and info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Keyla Sun',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'NPM: 714240048',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              color: porscheGold.withAlpha(220),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.white.withAlpha(30), height: 1),
                const SizedBox(height: 16),
                // Info rows
                _buildPassInfoRow(
                    Icons.school_outlined, 'Kelas 3A — D4 Teknik Informatika'),
                const SizedBox(height: 8),
                _buildPassInfoRow(Icons.apartment_outlined,
                    'Universitas Logistik & Bisnis Internasional'),
                const SizedBox(height: 8),
                _buildPassInfoRow(
                    Icons.code_outlined, 'ATS Pemrograman IV — 2026/2027'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: porscheSilver, size: 16),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════
  // 3. HIGHLIGHTS SECTION — Quick stats/spec cards
  // ═══════════════════════════════════════════
  Widget _buildHighlightsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildSectionTitle('HIGHLIGHTS'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.speed,
                  value: '518',
                  unit: 'PS',
                  label: 'Power',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.timer_outlined,
                  value: '3.2',
                  unit: 'sec',
                  label: '0–100 km/h',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.trending_up,
                  value: '296',
                  unit: 'km/h',
                  label: 'Top Speed',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String unit,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: porscheBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(icon, color: porscheRed, size: 22),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(
                    fontFamily: 'Oswald',
                    color: porscheGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.white.withAlpha(120),
              fontSize: 10,
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // 4. MODEL LINEUP — Daftar model kendaraan Porsche
  // ═══════════════════════════════════════════
  Widget _buildModelLineup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('MODELS'),
          const SizedBox(height: 16),
          _buildModelCard(
            title: '911 CARRERA',
            subtitle: 'Gasoline • Rear Engine • 2+2 Seats',
            desc: 'The icon that started it all. Timeless design meets relentless performance.',
            imageUrl:
                'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=800&auto=format&fit=crop',
            accent: porscheRed,
          ),
          const SizedBox(height: 14),
          _buildModelCard(
            title: 'TAYCAN',
            subtitle: 'Electric • All-Wheel Drive • 4 Doors',
            desc: 'Soul, electrified. Breathtaking performance with zero emissions.',
            imageUrl:
                'https://images.unsplash.com/photo-1617814076367-b759c7d7e738?q=80&w=800&auto=format&fit=crop',
            accent: const Color(0xFF00B4D8),
          ),
          const SizedBox(height: 14),
          _buildModelCard(
            title: 'CAYENNE',
            subtitle: 'Hybrid • Gasoline • 5 Seats',
            desc: 'The sports car of luxury SUVs. Adventure without compromise.',
            imageUrl:
                'https://images.unsplash.com/photo-1544829099-b9a0c07fad1a?q=80&w=800&auto=format&fit=crop',
            accent: porscheGold,
          ),
          const SizedBox(height: 14),
          _buildModelCard(
            title: 'MACAN ELECTRIC',
            subtitle: 'Electric • Compact SUV • Sport Chrono',
            desc: 'Compact. Athletic. Fully electric. The next generation begins.',
            imageUrl:
                'https://images.unsplash.com/photo-1580273916550-e323be2ae537?q=80&w=800&auto=format&fit=crop',
            accent: const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildModelCard({
    required String title,
    required String subtitle,
    required String desc,
    required String imageUrl,
    required Color accent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Stack(
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  color: porscheBlack,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Center(
                      child:
                          Icon(Icons.directions_car, color: accent, size: 60),
                    ),
                  ),
                ),
                // Accent strip at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 60,
                    height: 3,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: porscheBlack,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w600,
                        color: accent,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 14, color: accent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // 5. EXPERIENCE SECTION — Porsche brand story
  // ═══════════════════════════════════════════
  Widget _buildExperienceSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [porscheBlack, Color(0xFF2D2D2D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40, height: 3, color: porscheRed),
          const SizedBox(height: 14),
          const Text(
            'PORSCHE EXPERIENCE',
            style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Setiap Porsche diciptakan bukan sekadar untuk dikendarai — '
            'melainkan untuk dirasakan. Dari aspal sirkuit hingga jalan raya, '
            'filosofi "Intelligent Performance" menjadi DNA setiap modelnya.',
            style: TextStyle(
              color: Colors.white.withAlpha(180),
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          // Feature pills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFeaturePill('Rear Engine'),
              _buildFeaturePill('PDK Transmission'),
              _buildFeaturePill('Sport Chrono'),
              _buildFeaturePill('Porsche Stability'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: porscheGold.withAlpha(100)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Oswald',
          color: porscheGold.withAlpha(200),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  // 6. FOOTER
  // ═══════════════════════════════════════════
  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      color: porscheBlack,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'PORSCHE INDONESIA',
            style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Container(width: 30, height: 2, color: porscheRed),
          const SizedBox(height: 12),
          Text(
            '© 2026 Dr. Ing. h.c. F. Porsche AG',
            style: TextStyle(
              color: Colors.white.withAlpha(100),
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ATS Pemrograman IV • Keyla Sun • 714240048 • ULBI',
            style: TextStyle(
              color: Colors.white.withAlpha(70),
              fontSize: 10,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // SECTION TITLE HELPER
  // ═══════════════════════════════════════════
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: porscheBlack,
          ),
        ),
        const SizedBox(height: 4),
        Container(width: 35, height: 3, color: porscheRed),
      ],
    );
  }
}

