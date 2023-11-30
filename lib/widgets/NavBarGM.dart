import 'package:flutter/material.dart';

class NavBarGM extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  NavBarGM({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note_outlined),
          label: 'Customer Baru',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note_rounded),
          label: 'Top 5',
        ),
      ],
    );
  }
}
