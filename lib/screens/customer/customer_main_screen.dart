import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_theme.dart';

class CustomerMainScreen extends StatefulWidget {
  final Widget child;

  const CustomerMainScreen({super.key, required this.child});

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  int _currentIndex = 0;

  final List<String> _routes = [
    '/home',
    '/search',
    '/my-bookings',
    '/favorites',
    '/profile',
  ];

  @override
  void initState() {
    super.initState();
    // In a real app we'd sync this with GoRouter's state
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
