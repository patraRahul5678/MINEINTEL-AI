import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'ask_ai_screen.dart';
import 'knowledge_screen.dart';
import 'reports_screen.dart';

class MainNavScreen extends StatefulWidget {
  final String role;
  const MainNavScreen({super.key, this.role = 'Mining Engineer'});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _index = 0;

  late final List<Widget> _screens = [
    DashboardScreen(role: widget.role, onNavigate: _goTo),
    const AskAIScreen(),
    const KnowledgeScreen(),
    const ReportsScreen(),
  ];

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _goTo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.space_dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology_alt_rounded), label: 'Ask AI'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_copy_rounded), label: 'Knowledge'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Reports'),
        ],
      ),
    );
  }
}
