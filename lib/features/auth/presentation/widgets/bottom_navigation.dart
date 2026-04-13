// lib/widgets/bottom_navigation.dart (updated)
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  
  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C5F2D).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          selectedItemColor: const Color(0xFF2C5F2D),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          onTap: (index) {
            _navigateToScreen(context, index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel_rounded),
              label: 'Packages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Planner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (ModalRoute.of(context)?.settings.name != '/') {
          Navigator.pushNamed(context, '/');
        }
        break;
      case 1:
        Navigator.pushNamed(context, '/packages');
        break;
      case 2:
        Navigator.pushNamed(context, '/planner');
        break;
      case 3:
        Navigator.pushNamed(context, '/services');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}