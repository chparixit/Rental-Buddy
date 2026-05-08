import 'package:flutter/material.dart';
import 'package:rental_buddy/auth/login_screen.dart';
import 'package:rental_buddy/auth/register_screen.dart';
import 'package:rental_buddy/onboard/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _pulseController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _subtitleSlide =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );

    _pulse = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Sequence animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _logoController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _textController.forward();
    });

    // Navigate after splash
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F0FB), Color(0xFFDDE8F8), Color(0xFFEAF1FC)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Decorative arc at top (the large circle outline visible in screenshot)
            Positioned(
              top: -size.width * 0.55,
              left: -size.width * 0.2,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulse.value,
                    child: Container(
                      width: size.width * 1.4,
                      height: size.width * 1.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1A56A0).withOpacity(0.08),
                          width: 1.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Second decorative arc
            Positioned(
              top: -size.width * 0.7,
              left: -size.width * 0.35,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 2.0 - _pulse.value * 0.5,
                    child: Container(
                      width: size.width * 1.7,
                      height: size.width * 1.7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1A56A0).withOpacity(0.05),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main centered content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App icon
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1A56A0).withOpacity(0.12),
                              blurRadius: 30,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              blurRadius: 10,
                              spreadRadius: -2,
                              offset: const Offset(-4, -4),
                            ),
                          ],
                        ),
                        child: const Center(child: _HomeLocationIcon(size: 56)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // App name
                  FadeTransition(
                    opacity: _textFade,
                    child: SlideTransition(
                      position: _textSlide,
                      child: const Text(
                        'Rental Buddy',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A56A0),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Subtitle
                  FadeTransition(
                    opacity: _subtitleFade,
                    child: SlideTransition(
                      position: _subtitleSlide,
                      child: const Text(
                        'Find your perfect home in\nKathmandu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4B5563),
                          height: 1.55,
                          fontWeight: FontWeight.w400,
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

/// Custom painter that draws a location pin with a house inside.
class _HomeLocationIcon extends StatelessWidget {
  final double size;
  const _HomeLocationIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _HomeLocationPainter()),
    );
  }
}

class _HomeLocationPainter extends CustomPainter {
  static const Color _blue = Color(0xFF1A56A0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _blue
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // --- Draw location pin shape ---
    final pinPath = Path();
    final cx = w / 2;
    final pinTop = h * 0.04;
    final r = w * 0.42; // radius of the circular head
    final cy = pinTop + r; // center of circle

    // Circle top of pin
    pinPath.addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));

    // Triangle tail pointing down
    final tailTop = cy + r * 0.65;
    final tailWidth = r * 0.55;
    pinPath.moveTo(cx - tailWidth, tailTop);
    pinPath.quadraticBezierTo(cx, h * 0.97, cx, h * 0.97);
    pinPath.quadraticBezierTo(cx, h * 0.97, cx + tailWidth, tailTop);
    pinPath.close();

    canvas.drawPath(pinPath, paint);

    // --- White circle cutout inside pin (for house) ---
    final innerR = r * 0.70;
    canvas.drawCircle(Offset(cx, cy), innerR, Paint()..color = Colors.white);

    // --- Draw house icon inside the white circle ---
    final housePaint = Paint()
      ..color = _blue
      ..style = PaintingStyle.fill;

    final houseW = innerR * 1.1;
    final houseH = innerR * 1.0;
    final houseLeft = cx - houseW / 2;
    final houseTop = cy - houseH / 2 + innerR * 0.06;

    // Roof (triangle)
    final roofHeight = houseH * 0.42;
    final roofPath = Path();
    roofPath.moveTo(cx, houseTop); // apex
    roofPath.lineTo(houseLeft + houseW, houseTop + roofHeight);
    roofPath.lineTo(houseLeft, houseTop + roofHeight);
    roofPath.close();
    canvas.drawPath(roofPath, housePaint);

    // Body (rectangle)
    final bodyTop = houseTop + roofHeight - 1;
    final bodyHeight = houseH * 0.52;
    canvas.drawRect(
      Rect.fromLTWH(
        houseLeft + houseW * 0.08,
        bodyTop,
        houseW * 0.84,
        bodyHeight,
      ),
      housePaint,
    );

    // Door (white cutout)
    final doorW = houseW * 0.28;
    final doorH = bodyHeight * 0.56;
    final doorLeft = cx - doorW / 2;
    final doorTop = bodyTop + bodyHeight - doorH;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(doorLeft, doorTop, doorW, doorH),
        topLeft: const Radius.circular(2),
        topRight: const Radius.circular(2),
      ),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
