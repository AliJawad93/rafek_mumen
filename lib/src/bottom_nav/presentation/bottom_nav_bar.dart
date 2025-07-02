// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafek_mumen/src/home/presentation/home.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';

import '../../../utils/theme/sizes.dart';
import '../../quran/presentation/pages/quran_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
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
      // const Mustahbat(),
      // const Compass(),
      // const Rosary()
    ];
    unSelectedColor = Colors.grey;
    selectedColor = kPrimaryColor;
    backgroundColor = kSecondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: backgroundColor,
              elevation: 0,
              currentIndex: currentIndex,
              unselectedItemColor: unSelectedColor,
              fixedColor: selectedColor,
              onTap: (v) {
                setState(() {
                  currentIndex = v;
                });
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    "assets/images/praying2.png",
                    width: buttomNavIconSize,
                    height: buttomNavIconSize,
                  ),
                  icon: SvgPicture.asset(
                    "assets/images/praying_outline.svg",
                    width: buttomNavIconSize,
                    height: buttomNavIconSize,
                  ),
                  label: "الشاشه الرئيسيه",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/quran_outline.png",
                    width: buttomNavIconSize - 5,
                    height: buttomNavIconSize - 5,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/quran2.png",
                    width: buttomNavIconSize - 5,
                    height: buttomNavIconSize - 5,
                  ),
                  label: "القران",
                ),
              ],
            ),
          ],
        ),
        // body: pages[currentIndex],
        body: IndexedStack(index: currentIndex, children: pages),
      ),
    );
  }
}
