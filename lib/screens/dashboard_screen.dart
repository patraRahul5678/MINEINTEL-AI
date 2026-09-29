import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  final String role;
  final void Function(int index) onNavigate;
  const DashboardScreen({super.key, required this.role, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            title: Row(
              children: [
                const MineIntelLogo(size: 32),
                const SizedBox(width: 10),
                const Text('MineIntel AI', style: TextStyle(letterSpacing: -0.3)),
              ],
            ),
            actions: [
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.notifications_none_rounded),
                    Positioned(
                      right: 0, top: 0,
                      child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle)),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              const CircleAvatar(radius: 16, backgroundColor: AppColors.surfaceLight, child: Icon(Icons.person, size: 18, color: AppColors.textSecondary)),
              const SizedBox(width: 12),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text('Signed in as $role', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 4),
                const Text('Data is everywhere.\nIntelligence isn\'t — until now.',
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 24, height: 1.15, fontWeight: FontWeight.w800, letterSpacing: -0.6)),
                const SizedBox(height: 22),

                // ---- Trust Score card (radial gauges, like "Creator Value") ----
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF101C24), Color(0xFF0B141C)]),
                    border: Border.all(color: AppColors.teal.withOpacity(0.16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(color: AppColors.teal.withOpacity(0.15), borderRadius: BorderRadius.circular(9)),
                            child: const Icon(Icons.verified_outlined, size: 15, color: AppColors.teal),
                          ),
                          const SizedBox(width: 9),
                          const Text('TRUST SCORE (TS)', style: TextStyle(color: AppColors.textSecondary, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text('How reliable this week\'s evidence base is', style: TextStyle(color: AppColors.textMuted, fontSize: 11.5)),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          RadialGauge(value: 93, label: 'EVIDENCE\nCOVERAGE', color: AppColors.teal),
                          RadialGauge(value: 71, label: 'CITATION\nCONFIDENCE', color: AppColors.gold),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(height: 1),
                      const SizedBox(height: 14),
                      const Text('VERIFICATION ENGINE', style: TextStyle(color: AppColors.textMuted, fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _EngineIcon(icon: Icons.rule_folder_outlined, label: 'Rules'),
                          _EngineIcon(icon: Icons.calculate_outlined, label: 'Calc'),
                          _EngineIcon(icon: Icons.compare_arrows_rounded, label: 'Compare'),
                          _EngineIcon(icon: Icons.flag_outlined, label: 'Flag'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ---- Document Pipeline funnel (like "Fan Segments") ----
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Document Pipeline', style: TextStyle(color: AppColors.textPrimary, fontSize: 14.5, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      const Text('Where this week\'s 1,284 records stand', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      const SizedBox(height: 16),
                      FunnelChart(stages: [
                        FunnelStage('Ingested', 1284, AppColors.cyan),
                        FunnelStage('OCR / Extracted', 1189, AppColors.teal),
                        FunnelStage('Indexed', 1042, AppColors.gold),
                        FunnelStage('Verified', 861, AppColors.success),
                      ]),
                      const SizedBox(height: 4),
                      const Divider(height: 1),
                      const SizedBox(height: 14),
                      const Text('VERIFICATION SIGNALS', style: TextStyle(color: AppColors.textMuted, fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                      const SizedBox(height: 12),
                      const SignalRow(icon: Icons.document_scanner_outlined, label: 'OCR Confidence', percent: 94, color: AppColors.teal),
                      const SignalRow(icon: Icons.link_rounded, label: 'Citation Accuracy', percent: 88, color: AppColors.cyan),
                      const SignalRow(icon: Icons.functions_rounded, label: 'Calculation Match', percent: 99, color: AppColors.success),
                      const SignalRow(icon: Icons.report_gmailerrorred_rounded, label: 'Conflict Rate', percent: 4, color: AppColors.danger),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ---- Quick actions (pill icon tiles) ----
                const SectionHeader(title: 'Quick Actions'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryIconAction(icon: Icons.psychology_alt_rounded, label: 'Ask AI', color: AppColors.cyan, onTap: () => onNavigate(1)),
                    PrimaryIconAction(icon: Icons.upload_file_rounded, label: 'Upload Doc', color: AppColors.gold, onTap: () => onNavigate(2)),
                    PrimaryIconAction(icon: Icons.summarize_outlined, label: 'New Report', color: AppColors.info, onTap: () => onNavigate(3)),
                    PrimaryIconAction(icon: Icons.fact_check_outlined, label: 'Verify', color: AppColors.success, onTap: () => onNavigate(3)),
                  ],
                ),
                const SizedBox(height: 22),

                // ---- Tagline card (like "Technology Built to See What Others Can't") ----
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF13202B), Color(0xFF0B141C)]),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('AI That Shows\nIts Work', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, height: 1.2, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
                            SizedBox(height: 8),
                            Text('Every answer traces back to a page, a sheet, and a formula — not model memory.',
                                style: TextStyle(color: AppColors.textSecondary, fontSize: 11.5, height: 1.5)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 74,
                          child: Stack(alignment: Alignment.center, children: const [
                            GlowCrystal(icon: Icons.hub_outlined, size: 34, color: AppColors.cyan),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),

                SectionHeader(title: 'Recent Activity', actionLabel: 'View Audit', onAction: () {}),
                ...[
                  _ActivityData(Icons.upload_file_rounded, AppColors.teal, 'Talcher_Annual_Report_2025.pdf ingested', '2 min ago'),
                  _ActivityData(Icons.psychology_alt_rounded, AppColors.gold, "Query answered — 'Stripping ratio for Block-A, FY24'", '18 min ago'),
                  _ActivityData(Icons.report_gmailerrorred_rounded, AppColors.danger, 'Conflict flagged in production figures — Mine SECL-07', '1 hr ago'),
                  _ActivityData(Icons.check_circle_outline_rounded, AppColors.success, 'Quarterly Reserve Report approved by Reviewer', '3 hr ago'),
                ].map((a) => _ActivityTile(data: a)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _EngineIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _EngineIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceLight),
          child: Icon(icon, size: 17, color: AppColors.cyan),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10.5, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _ActivityData {
  final IconData icon;
  final Color color;
  final String text;
  final String time;
  _ActivityData(this.icon, this.color, this.text, this.time);
}

class _ActivityTile extends StatelessWidget {
  final _ActivityData data;
  const _ActivityTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: data.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(data.icon, color: data.color, size: 17),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(data.text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12.8, height: 1.3)),
            ),
            const SizedBox(width: 8),
            Text(data.time, style: const TextStyle(color: AppColors.textMuted, fontSize: 10.5)),
          ],
        ),
      ),
    );
  }
}
