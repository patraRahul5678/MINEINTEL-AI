import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'login_screen.dart';

/// Combined splash + hero welcome screen. A brief logo intro cross-fades
/// into a bold, dark hero layout (headline, floating crystals, pill CTAs) —
/// styled after the reference "Fandom. Certified." welcome screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  bool _showHero = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _logoFade = CurvedAnimation(parent: _controller, curve: const Interval(0, 0.7, curve: Curves.easeOut));
    _logoScale = Tween<double>(begin: 0.82, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1300), () {
      if (mounted) setState(() => _showHero = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: Stack(
          children: [
            const CrystalField(),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 550),
              child: _showHero ? const _HeroContent(key: ValueKey('hero')) : _LogoIntro(key: const ValueKey('logo'), fade: _logoFade, scale: _logoScale),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoIntro extends StatelessWidget {
  final Animation<double> fade;
  final Animation<double> scale;
  const _LogoIntro({super.key, required this.fade, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fade,
        child: ScaleTransition(
          scale: scale,
          child: const MineIntelLogo(size: 100),
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar — wordmark + a small status pill (mirrors "Contact us").
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const MineIntelLogo(size: 30),
                    const SizedBox(width: 9),
                    const Text('MINEINTEL',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 1.6)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.14)),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Bold two-line headline.
            const Text(
              'Evidence.\nCertified.',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 44,
                height: 1.05,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Records are everywhere. Intelligence isn\'t.\nMineIntel AI reveals what your data has been hiding —\nwith citations, verification and audit trails built in.',
              style: TextStyle(color: AppColors.textSecondary.withOpacity(0.95), fontSize: 13.5, height: 1.55),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 450),
                    pageBuilder: (_, anim, __) => const LoginScreen(),
                    transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
                  ),
                ),
                child: const Text('Explore the Platform'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: const Text('Partner With CMPDI / CIL'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
