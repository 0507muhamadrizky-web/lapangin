import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../config/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      icon: Icons.search_rounded,
      title: 'Temukan Lapangan',
      subtitle: 'Cari lapangan olahraga terdekat dari lokasimu. Futsal, badminton, basket, dan lainnya.',
      gradient: const LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    _OnboardingData(
      icon: Icons.calendar_today_rounded,
      title: 'Booking Mudah',
      subtitle: 'Pilih tanggal dan jam yang tersedia, lakukan booking dan bayar secara online.',
      gradient: const LinearGradient(
        colors: [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    _OnboardingData(
      icon: Icons.qr_code_scanner_rounded,
      title: 'Check-in dengan QR',
      subtitle: 'Dapatkan QR Code setelah booking dan tunjukkan saat datang ke lokasi.',
      gradient: const LinearGradient(
        colors: [Color(0xFF059669), Color(0xFF10B981)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    'Lewati',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon container
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: page.gradient,
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: page.gradient.colors.first.withOpacity(0.3),
                                blurRadius: 40,
                                offset: const Offset(0, 16),
                              ),
                            ],
                          ),
                          child: Icon(
                            page.icon,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom section
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(
                children: [
                  // Dot indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.primary.withOpacity(0.2),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                      spacing: 6,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          context.go('/login');
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Mulai Sekarang' : 'Lanjut',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final String title;
  final String subtitle;
  final LinearGradient gradient;

  _OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}
