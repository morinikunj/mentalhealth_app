import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/schedules_screen.dart';
import 'package:mentalhealth_app/user/chatbot/presentation/chatbotscreen.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/dashboard.dart';
import 'package:mentalhealth_app/user/expert_booking/presentation/homepage.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/profilepage_screen.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedItem = 0;
  List screens = [
    DashboardPage(),
    HomeScreen(),
    ChatbotScreen(),
    SchedulePage(),
    ProfilePage(),
  ];

  void ontap(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mentalBrandColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: ontap,
        currentIndex: _selectedItem,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Psycologists'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Psycologists'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Psycologists'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Psycologists'),
        ],
      ),
    );
  }
}
