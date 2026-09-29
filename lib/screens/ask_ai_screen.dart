import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class _ChatMessage {
  final bool isUser;
  final String text;
  final List<String>? sources;
  final double? confidence;
  final Map<String, String>? calcTrace;
  _ChatMessage.user(this.text) : isUser = true, sources = null, confidence = null, calcTrace = null;
  _ChatMessage.ai(this.text, {this.sources, this.confidence, this.calcTrace}) : isUser = false;
}

class AskAIScreen extends StatefulWidget {
  const AskAIScreen({super.key});

  @override
  State<AskAIScreen> createState() => _AskAIScreenState();
}

class _AskAIScreenState extends State<AskAIScreen> {
  final _controller = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _thinking = false;

  final List<_ChatMessage> _messages = [
    _ChatMessage.ai(
      "I'm your MineIntel assistant. Ask me about production, geology, boreholes, or reports — every answer comes with cited evidence.",
    ),
  ];

  final _suggestions = const [
    'What was the production for Block-A, FY2024?',
    'Show stripping ratio for SECL-07',
    'Any conflicting reserve figures?',
    'Summarize borehole BH-114 findings',
  ];

  void _send([String? text]) {
    final query = (text ?? _controller.text).trim();
    if (query.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage.user(query));
      _controller.clear();
      _thinking = true;
    });
    _scrollToEnd();

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _thinking = false;
        if (query.toLowerCase().contains('stripping') || query.toLowerCase().contains('ratio')) {
          _messages.add(_ChatMessage.ai(
            'For SECL-07 (FY2024), the stripping ratio is 4.8 : 1, derived from overburden removed against coal produced in the period.',
            sources: ['SECL07_Annual_Report_2024.pdf · p.34', 'Overburden_Register_FY24.xlsx · Sheet 2'],
            confidence: 0.93,
            calcTrace: {
              'Formula': 'Stripping Ratio = Overburden Volume ÷ Coal Production',
              'Overburden Volume': '18,240,000 m³',
              'Coal Production': '3,800,000 t',
              'Result': '4.8 : 1',
            },
          ));
        } else if (query.toLowerCase().contains('conflict')) {
          _messages.add(_ChatMessage.ai(
            'One conflict detected: FY2023 production for Mine SECL-07 differs between two sources by 6.2%. Flagging rather than auto-resolving.',
            sources: ['SECL07_Annual_Report_2023.pdf · p.12', 'Monthly_Production_Log_2023.xlsx · Sheet 7'],
            confidence: 0.71,
          ));
        } else {
          _messages.add(_ChatMessage.ai(
            'Production for Block-A in FY2024 was 2.46 million tonnes, against a target of 2.30 million tonnes — a 7% overachievement.',
            sources: ['BlockA_Annual_Report_2024.pdf · p.9', 'Production_Summary_FY24.xlsx · Sheet 1'],
            confidence: 0.96,
          ));
        }
      });
      _scrollToEnd();
    });
  }

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(color: AppColors.teal.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.psychology_alt_rounded, color: AppColors.teal, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI Reporting Assistant', style: TextStyle(color: AppColors.textPrimary, fontSize: 16.5, fontWeight: FontWeight.w800)),
                      Text('Evidence-backed Q&A over approved knowledge', style: TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_thinking ? 1 : 0),
              itemBuilder: (context, i) {
                if (i == _messages.length) return const _ThinkingBubble();
                return _MessageBubble(message: _messages[i]);
              },
            ),
          ),
          if (_messages.length <= 1)
            SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _suggestions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => ActionChip(
                  label: Text(_suggestions[i]),
                  onPressed: () => _send(_suggestions[i]),
                  backgroundColor: AppColors.surfaceLight,
                  labelStyle: const TextStyle(fontSize: 11.5),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5),
                    decoration: const InputDecoration(
                      hintText: 'Ask about production, geology, reports…',
                      prefixIcon: Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textMuted, size: 19),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: const BoxDecoration(gradient: AppColors.goldTealGradient, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () => _send(),
                    icon: const Icon(Icons.arrow_upward_rounded, color: Color(0xFF10141A)),
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

class _ThinkingBubble extends StatelessWidget {
  const _ThinkingBubble();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.teal)),
            SizedBox(width: 10),
            Text('Retrieving evidence & verifying…', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser ? AppColors.goldTealGradient : null,
                color: isUser ? null : AppColors.card,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser ? const Color(0xFF10141A) : AppColors.textPrimary,
                  fontSize: 13.3,
                  height: 1.4,
                  fontWeight: isUser ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (message.confidence != null) ...[
              const SizedBox(height: 8),
              ConfidenceBadge(confidence: message.confidence!),
            ],
            if (message.calcTrace != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.teal.withOpacity(0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: const [
                      Icon(Icons.calculate_outlined, size: 14, color: AppColors.teal),
                      SizedBox(width: 6),
                      Text('Calculation Trace', style: TextStyle(color: AppColors.teal, fontSize: 11.5, fontWeight: FontWeight.w700)),
                    ]),
                    const SizedBox(height: 8),
                    ...message.calcTrace!.entries.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              SizedBox(width: 118, child: Text(e.key, style: const TextStyle(color: AppColors.textMuted, fontSize: 11))),
                              Expanded(child: Text(e.value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 11.5, fontWeight: FontWeight.w600))),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
            if (message.sources != null) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: message.sources!
                    .map((s) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.description_outlined, size: 12, color: AppColors.gold),
                              const SizedBox(width: 5),
                              Text(s, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10.5)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
