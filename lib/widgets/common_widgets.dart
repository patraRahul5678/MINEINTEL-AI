import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Scattered translucent geology/AI icons used behind splash & login content.
class GeoIconBackdrop extends StatelessWidget {
  const GeoIconBackdrop({super.key});

  static const _icons = [
    Icons.terrain_rounded,
    Icons.diamond_outlined,
    Icons.auto_awesome,
    Icons.layers_outlined,
    Icons.insights_rounded,
    Icons.hub_outlined,
    Icons.landscape_rounded,
    Icons.query_stats_rounded,
  ];

  static const List<List<double>> _positions = [
    [0.06, 0.10, 46],
    [0.78, 0.08, 34],
    [0.14, 0.78, 38],
    [0.82, 0.72, 50],
    [0.50, 0.05, 28],
    [0.90, 0.40, 30],
    [0.05, 0.45, 30],
    [0.40, 0.88, 34],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IgnorePointer(
      child: Stack(
        children: List.generate(_icons.length, (i) {
          final p = _positions[i];
          return Positioned(
            left: size.width * p[0],
            top: size.height * p[1],
            child: Icon(_icons[i], size: p[2], color: Colors.white.withOpacity(0.06)),
          );
        }),
      ),
    );
  }
}

/// A small glowing "crystal" — a soft blurred halo behind a gem-like icon.
/// Used to scatter floating decorations across dark hero surfaces, echoing
/// the faceted, data-crystal motif of the reference design.
class GlowCrystal extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  const GlowCrystal({super.key, required this.icon, this.size = 40, this.color = AppColors.cyan});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.8,
      height: size * 1.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 1.6,
            height: size * 1.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: color.withOpacity(0.35), blurRadius: size * 0.9, spreadRadius: size * 0.05)],
            ),
          ),
          ShaderMask(
            shaderCallback: (b) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withOpacity(0.55)],
            ).createShader(b),
            child: Icon(icon, size: size, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

/// Scattered glow-crystal field for hero surfaces (splash / welcome screens).
class CrystalField extends StatelessWidget {
  const CrystalField({super.key});

  static const _items = [
    [0.08, 0.09, 30.0, AppColors.cyan, Icons.diamond_outlined],
    [0.80, 0.06, 24.0, AppColors.gold, Icons.hexagon_outlined],
    [0.12, 0.30, 20.0, AppColors.teal, Icons.change_history_rounded],
    [0.86, 0.24, 30.0, AppColors.cyan, Icons.diamond_outlined],
    [0.68, 0.15, 16.0, AppColors.gold, Icons.hexagon_outlined],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IgnorePointer(
      child: Stack(
        children: _items.map((it) {
          return Positioned(
            left: size.width * (it[0] as double) - (it[2] as double),
            top: size.height * (it[1] as double) - (it[2] as double),
            child: GlowCrystal(icon: it[4] as IconData, size: it[2] as double, color: it[3] as Color),
          );
        }).toList(),
      ),
    );
  }
}

/// Circular gauge for a 0–100 score, echoing the "71 / 93" dials in the
/// reference design. `label` sits below the number inside the ring.
class RadialGauge extends StatelessWidget {
  final double value; // 0..100
  final String label;
  final Color color;
  final double size;
  const RadialGauge({super.key, required this.value, required this.label, this.color = AppColors.cyan, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 7,
              color: AppColors.surfaceLight,
            ),
          ),
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: (value / 100).clamp(0, 1),
              strokeWidth: 7,
              strokeCap: StrokeCap.round,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value.round().toString(),
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 9.5, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

/// A funnel-style stage chart — decreasing-width bars, one per pipeline
/// stage — used for things like the document ingestion pipeline.
class FunnelChart extends StatelessWidget {
  final List<FunnelStage> stages;
  const FunnelChart({super.key, required this.stages});

  @override
  Widget build(BuildContext context) {
    final maxCount = stages.first.count.toDouble();
    return Column(
      children: stages.map((s) {
        final widthFactor = (s.count / maxCount).clamp(0.18, 1.0);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                width: 78,
                child: Text(s.label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: widthFactor,
                    child: Container(
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(colors: [s.color, s.color.withOpacity(0.55)]),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 8),
                      child: Text('${s.count}',
                          style: const TextStyle(color: Color(0xFF070B12), fontSize: 10.5, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class FunnelStage {
  final String label;
  final int count;
  final Color color;
  FunnelStage(this.label, this.count, this.color);
}

/// A single labeled signal row with a percentage and a dot-strength meter —
/// echoes the "Behavioral Trends" rows in the reference design.
class SignalRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int percent;
  final Color color;
  const SignalRow({super.key, required this.icon, required this.label, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    final dots = (percent / 20).round().clamp(1, 5);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
          ),
          Row(
            children: List.generate(5, (i) => Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Container(
                    width: 6, height: 6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: i < dots ? color : AppColors.surfaceLight),
                  ),
                )),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text('$percent%', textAlign: TextAlign.right, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

/// The MineIntel AI emblem: layered terrain + AI spark, used on splash & app bar.
class MineIntelLogo extends StatelessWidget {
  final double size;
  const MineIntelLogo({super.key, this.size = 88});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.goldTealGradient,
        boxShadow: [
          BoxShadow(color: AppColors.teal.withOpacity(0.35), blurRadius: 30, spreadRadius: 2),
        ],
      ),
      child: Center(
        child: Container(
          width: size - 14,
          height: size - 14,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.background),
          child: Icon(Icons.terrain_rounded, color: Colors.white, size: size * 0.46),
        ),
      ),
    );
  }
}

class ConfidenceBadge extends StatelessWidget {
  final double confidence; // 0..1
  const ConfidenceBadge({super.key, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final pct = (confidence * 100).round();
    Color color;
    String label;
    if (confidence >= 0.85) {
      color = AppColors.success;
      label = 'High';
    } else if (confidence >= 0.6) {
      color = AppColors.warning;
      label = 'Medium';
    } else {
      color = AppColors.danger;
      label = 'Low';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 7, color: color),
          const SizedBox(width: 5),
          Text('$label · $pct%', style: TextStyle(color: color, fontSize: 11.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const StatusPill({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withOpacity(0.16), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11.5, fontWeight: FontWeight.w700)),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 16.5, fontWeight: FontWeight.w700)),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(actionLabel!,
                  style: const TextStyle(color: AppColors.teal, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color accent;
  final String? trend;
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.accent,
    this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardSheenGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(color: accent.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: 14),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
          if (trend != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.trending_up_rounded, color: AppColors.success, size: 14),
                const SizedBox(width: 4),
                Text(trend!, style: const TextStyle(color: AppColors.success, fontSize: 11.5, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class PrimaryIconAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  const PrimaryIconAction({super.key, required this.icon, required this.label, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
