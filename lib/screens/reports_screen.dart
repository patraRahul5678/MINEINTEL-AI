import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class _Report {
  final String title, subsidiary, date, status;
  final Color statusColor;
  _Report(this.title, this.subsidiary, this.date, this.status, this.statusColor);
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  static final List<_Report> _reports = [
    _Report('Quarterly Reserve Report — Q2 FY26', 'BCCL', 'Due 30 Sep', 'Draft', AppColors.info),
    _Report('Annual Production Summary 2025', 'MCL', 'Submitted 12 Sep', 'Under Review', AppColors.warning),
    _Report('Stripping Ratio Analysis — SECL Blocks', 'SECL', 'Approved 08 Sep', 'Approved', AppColors.success),
    _Report('Geological Survey Digest — BH-114', 'CMPDI', 'Approved 02 Sep', 'Approved', AppColors.success),
    _Report('Conflict Resolution Memo — Mine SECL-07', 'SECL', 'Flagged 26 Aug', 'Needs Verification', AppColors.danger),
  ];

  void _openGenerateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _GenerateReportSheet(),
    );
  }

  void _openReportDetail(BuildContext context, _Report r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ReportDetailSheet(report: r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(color: AppColors.info.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.assignment_rounded, color: AppColors.info, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Report Studio', style: TextStyle(color: AppColors.textPrimary, fontSize: 16.5, fontWeight: FontWeight.w800)),
                          Text('Templates · evidence insertion · approvals', style: TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                  children: [
                    for (final r in _reports) ...[
                      InkWell(
                        onTap: () => _openReportDetail(context, r),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(r.title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w700)),
                                  ),
                                  StatusPill(label: r.status, color: r.statusColor),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.apartment_rounded, size: 13, color: AppColors.textMuted),
                                  const SizedBox(width: 5),
                                  Text(r.subsidiary, style: const TextStyle(color: AppColors.textMuted, fontSize: 11.5)),
                                  const SizedBox(width: 14),
                                  const Icon(Icons.schedule_rounded, size: 13, color: AppColors.textMuted),
                                  const SizedBox(width: 5),
                                  Text(r.date, style: const TextStyle(color: AppColors.textMuted, fontSize: 11.5)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () => _openGenerateSheet(context),
              backgroundColor: AppColors.gold,
              foregroundColor: const Color(0xFF10141A),
              icon: const Icon(Icons.add_rounded),
              label: const Text('New Report', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenerateReportSheet extends StatelessWidget {
  const _GenerateReportSheet();

  @override
  Widget build(BuildContext context) {
    final templates = [
      ['Annual Production Report', Icons.bar_chart_rounded],
      ['Stripping Ratio Analysis', Icons.calculate_rounded],
      ['Geological Survey Digest', Icons.terrain_rounded],
      ['Reserve Estimation Report', Icons.layers_rounded],
      ['Conflict Resolution Memo', Icons.report_gmailerrorred_rounded],
    ];
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 18),
          const Text('Choose a Template', style: TextStyle(color: AppColors.textPrimary, fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text('Verified facts and evidence will be inserted automatically.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
          const SizedBox(height: 18),
          for (final t in templates)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(t[1] as IconData, color: AppColors.teal, size: 20),
                        const SizedBox(width: 14),
                        Expanded(child: Text(t[0] as String, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600))),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ReportDetailSheet extends StatelessWidget {
  final _Report report;
  const _ReportDetailSheet({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: Text(report.title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16.5, fontWeight: FontWeight.w800))),
              StatusPill(label: report.status, color: report.statusColor),
            ],
          ),
          const SizedBox(height: 6),
          Text('${report.subsidiary} · ${report.date}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
          const SizedBox(height: 20),
          const Text('EVIDENCE-BACKED SECTIONS', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          const SizedBox(height: 10),
          _section('Executive Summary', true),
          _section('Production & Reserves Table', true),
          _section('Verification & Conflict Notes', false),
          _section('Approval & Sign-off', false),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                  label: const Text('Export PDF'),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.textPrimary, side: const BorderSide(color: AppColors.surfaceLight), padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                  label: const Text('Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section(String title, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 18, color: done ? AppColors.success : AppColors.textMuted),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
        ],
      ),
    );
  }
}
