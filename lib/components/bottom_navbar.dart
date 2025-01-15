// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChange;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FBottomNavigationBar(
      index: currentIndex,
      onChange: onTabChange, // Pass index change to parent widget
      children: [
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.housePlug),
          label: const Text('Home'),
        ),
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.search),
          label: const Text('Events'),
        ),
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.calendar),
          label: const Text('Schedule'),
        ),
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.user),
          label: const Text('Profile'),
        ),
      ],
    );
  }
}
