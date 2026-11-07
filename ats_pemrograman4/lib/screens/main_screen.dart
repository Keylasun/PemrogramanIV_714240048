import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'home_screen.dart';
import 'contact_screen.dart';

/// Layar utama dengan Bottom Navigation Bar
/// Menggunakan IndexedStack agar state halaman tetap terjaga
/// saat berpindah antara Home dan Daftar Kontak
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Data kontak disimpan di MainScreen agar tetap tersedia
  // saat berpindah antara Home dan Daftar Kontak (sesuai ketentuan 2g)
  final List<ContactModel> _contacts = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          ContactScreen(
            contacts: _contacts,
            onContactsChanged: () {
              setState(() {});
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    const porscheBlack = Color(0xFF111111);
    const porscheRed = Color(0xFFD5001C);
    const porscheGold = Color(0xFFC5A059);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: porscheRed, width: 2),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: porscheBlack,
        selectedItemColor: porscheRed,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          fontSize: 10,
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.speed,
              color: _selectedIndex == 0 ? porscheRed : Colors.grey[500],
            ),
            activeIcon: Column(
              children: [
                Container(
                  width: 24,
                  height: 2,
                  color: porscheGold,
                ),
                const SizedBox(height: 4),
                const Icon(Icons.speed, color: porscheRed),
              ],
            ),
            label: 'PORSCHE HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contact_phone_outlined,
              color: _selectedIndex == 1 ? porscheRed : Colors.grey[500],
            ),
            activeIcon: Column(
              children: [
                Container(
                  width: 24,
                  height: 2,
                  color: porscheGold,
                ),
                const SizedBox(height: 4),
                const Icon(Icons.contact_phone, color: porscheRed),
              ],
            ),
            label: 'CLIENT REGISTRY',
          ),
        ],
      ),
    );
  }
}

