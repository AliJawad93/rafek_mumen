import 'package:flutter/material.dart';
import 'package:rafek_mumen/src/explore/presentation/pages/explore_page.dart';
import 'package:rafek_mumen/src/home/presentation/pages/home.dart';
import 'package:rafek_mumen/src/settings/presentation/pages/settings_page.dart';
import 'package:rafek_mumen/src/tasbih/presentation/pages/tasbih_counter_page.dart';

import '../../quran/presentation/pages/quran_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  late List<Widget> pages;
  bool isbill = true;
  late Color unSelectedColor;
  late Color selectedColor;
  late Color backgroundColor;
  @override
  void initState() {
    super.initState();
    // NotificationsService.setListeners();
    pages = [
      const HomePage(),
      const QuranPage(),
      const TasbihCounterPage(),
      const ExplorePage(),
      const SettingsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'القرآن'),

          NavigationDestination(
            icon: Icon(Icons.fingerprint),
            label: 'التسبيح',
          ),
          NavigationDestination(icon: Icon(Icons.explore), label: 'استكشاف'),

          NavigationDestination(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
    );
  }
}
