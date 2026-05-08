import 'package:flutter/material.dart';
import 'package:rental_buddy/auth/login_screen.dart';

void main() {
  runApp(const RentalBuddyApp());
}

class RentalBuddyApp extends StatelessWidget {
  const RentalBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A56A0)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

// ─────────────────────────────────────────────
// Data model for each onboarding page
// ─────────────────────────────────────────────
class OnboardingPage {
  final String title;
  final String subtitle;
  final String tag; // pill text
  final IconData iconData;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.iconData,
  });
}

const List<OnboardingPage> _pages = [
  OnboardingPage(
    title: 'Rental Buddy',
    subtitle: 'Find Your Perfect Home in the Valley',
    tag: 'KATHMANDU, NEPAL',
    iconData: Icons.home_work_rounded,
  ),
  OnboardingPage(
    title: 'Browse Listings',
    subtitle: 'Explore hundreds of verified rental properties near you',
    tag: 'VERIFIED LISTINGS',
    iconData: Icons.search_rounded,
  ),
  OnboardingPage(
    title: 'Move In Easy',
    subtitle: 'Connect with landlords and book viewings instantly',
    tag: 'HASSLE FREE',
    iconData: Icons.key_rounded,
  ),
];

// ─────────────────────────────────────────────
// Onboarding Screen
// ─────────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Per-page animation controllers
  late List<AnimationController> _slideControllers;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  static const Color _primaryBlue = Color(0xFF1A56A0);
  static const Color _bgColor = Color(0xFFF0F4F8);

  @override
  void initState() {
    super.initState();

    _slideControllers = List.generate(
      _pages.length,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );

    _slideAnimations = _slideControllers.map((ctrl) {
      return Tween<Offset>(
        begin: const Offset(0, 0.18),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeOut));
    }).toList();

    _fadeAnimations = _slideControllers.map((ctrl) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeIn));
    }).toList();

    // Animate first page in
    _slideControllers[0].forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _slideControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _slideControllers[index].forward(from: 0);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Page content (swipeable) ──
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: SlideTransition(
                      position: _slideAnimations[index],
                      child: _PageContent(page: page),
                    ),
                  );
                },
              ),
            ),

            // ── Dots indicator ──
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? _primaryBlue : const Color(0xFFBFCFE8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),

            // ── Get Started button ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _currentPage == _pages.length - 1
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        }
                      : _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Sign In link ──
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text(
                'Sign In to Account',
                style: TextStyle(
                  fontSize: 15,
                  color: _primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Footer tag ──
            const Text(
              'PREMIUM PROPERTY PORTAL',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Single page content widget
// ─────────────────────────────────────────────
class _PageContent extends StatelessWidget {
  final OnboardingPage page;
  const _PageContent({required this.page});

  static const Color _primaryBlue = Color(0xFF1A56A0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── App icon card ──
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _primaryBlue,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _primaryBlue.withOpacity(0.30),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(page.iconData, color: Colors.white, size: 58),
          ),

          const SizedBox(height: 36),

          // ── Title ──
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
              letterSpacing: 0.1,
            ),
          ),

          const SizedBox(height: 12),

          // ── Subtitle ──
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 32),

          // ── Location / tag pill ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 8),
                Text(
                  page.tag,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
