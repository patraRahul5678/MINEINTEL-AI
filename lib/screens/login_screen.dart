import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'main_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController(text: 'engineer@cmpdi.gov.in');
  final _passCtrl = TextEditingController(text: '••••••••');
  bool _obscure = true;
  String _role = 'Mining Engineer';
  bool _loading = false;

  final List<Map<String, dynamic>> _roles = const [
    {'label': 'Geologist', 'icon': Icons.terrain_rounded},
    {'label': 'Mining Engineer', 'icon': Icons.engineering_rounded},
    {'label': 'Reporting Officer', 'icon': Icons.description_rounded},
    {'label': 'Management', 'icon': Icons.insights_rounded},
    {'label': 'Reviewer / Approver', 'icon': Icons.fact_check_rounded},
    {'label': 'Administrator', 'icon': Icons.admin_panel_settings_rounded},
  ];

  void _signIn() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MainNavScreen(role: _role)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: Stack(
          children: [
            const CrystalField(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const MineIntelLogo(size: 68),
                    const SizedBox(height: 18),
                    const Text('Welcome back',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.6)),
                    const SizedBox(height: 6),
                    const Text('Sign in to your governed mining knowledge workspace.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5)),
                    const SizedBox(height: 30),

                    const Text('WORK EMAIL', style: TextStyle(color: AppColors.textMuted, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailCtrl,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.textMuted, size: 20),
                        hintText: 'you@subsidiary.gov.in',
                      ),
                    ),
                    const SizedBox(height: 18),

                    const Text('PASSWORD', style: TextStyle(color: AppColors.textMuted, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.textMuted, size: 20),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    const Text('SIGN IN AS', style: TextStyle(color: AppColors.textMuted, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _roles.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final r = _roles[i];
                          final selected = _role == r['label'];
                          return ChoiceChip(
                            selected: selected,
                            onSelected: (_) => setState(() => _role = r['label']),
                            avatar: Icon(r['icon'], size: 15, color: selected ? const Color(0xFF070B12) : AppColors.textSecondary),
                            label: Text(r['label']),
                            selectedColor: AppColors.cyan,
                            backgroundColor: AppColors.surfaceLight,
                            labelStyle: TextStyle(
                              color: selected ? const Color(0xFF070B12) : AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _signIn,
                        child: _loading
                            ? const SizedBox(
                                height: 20, width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2.4, color: Color(0xFF070B12)))
                            : const Text('Sign In Securely'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shield_outlined, size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 6),
                        Text('RBAC · Audit-logged · Enterprise encryption',
                            style: TextStyle(color: AppColors.textMuted.withOpacity(0.9), fontSize: 11.5)),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Center(
                      child: Text('SIH 2026 · Problem Statement 26023',
                          style: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 10.5)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
