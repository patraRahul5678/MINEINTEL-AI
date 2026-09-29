import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class _Doc {
  final String title, subsidiary, date, type;
  final IconData icon;
  final double confidence;
  _Doc(this.title, this.subsidiary, this.date, this.type, this.icon, this.confidence);
}

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  String _filter = 'All';
  final _filters = const ['All', 'Reports', 'Spreadsheets', 'Scans', 'Boreholes'];

  final List<_Doc> _docs = [
    _Doc('Talcher_Annual_Report_2025.pdf', 'MCL', '12 Sep 2026', 'Reports', Icons.picture_as_pdf_rounded, 0.97),
    _Doc('Overburden_Register_FY24.xlsx', 'SECL', '10 Sep 2026', 'Spreadsheets', Icons.table_chart_rounded, 0.99),
    _Doc('Borehole_Log_BH-114.pdf', 'CMPDI', '08 Sep 2026', 'Boreholes', Icons.terrain_rounded, 0.88),
    _Doc('Legacy_Survey_1998_Scan.tiff', 'ECL', '05 Sep 2026', 'Scans', Icons.image_search_rounded, 0.61),
    _Doc('Monthly_Production_Log_2023.xlsx', 'SECL', '02 Sep 2026', 'Spreadsheets', Icons.table_chart_rounded, 0.95),
    _Doc('Quarterly_Reserve_Report_Q2.pdf', 'BCCL', '29 Aug 2026', 'Reports', Icons.picture_as_pdf_rounded, 0.93),
    _Doc('Borehole_Log_BH-098.pdf', 'CMPDI', '25 Aug 2026', 'Boreholes', Icons.terrain_rounded, 0.79),
  ];

  List<_Doc> get _filtered => _filter == 'All' ? _docs : _docs.where((d) => d.type == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.folder_copy_rounded, color: AppColors.gold, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mining Knowledge Hub', style: TextStyle(color: AppColors.textPrimary, fontSize: 16.5, fontWeight: FontWeight.w800)),
                      Text('1,284 documents · normalized & indexed', style: TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.upload_file_rounded, color: AppColors.textSecondary), onPressed: () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5),
              decoration: const InputDecoration(
                hintText: 'Search mine, borehole ID, report, keyword…',
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final f = _filters[i];
                final selected = _filter == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = f),
                  selectedColor: AppColors.teal,
                  backgroundColor: AppColors.surfaceLight,
                  labelStyle: TextStyle(color: selected ? const Color(0xFF10141A) : AppColors.textSecondary, fontWeight: FontWeight.w700, fontSize: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final d = _filtered[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(gradient: AppColors.cardSheenGradient, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12)),
                        child: Icon(d.icon, color: AppColors.gold, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('${d.subsidiary} · ${d.date}', style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ConfidenceBadge(confidence: d.confidence),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
