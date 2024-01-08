import 'package:chitto_demo/screens/home/tabs/CertificateTab.dart';
import 'package:flutter/material.dart';

import 'WinCertificatePage.dart';
import 'tabs/ChatTab.dart';
import 'tabs/ProfileTab.dart';
import 'tabs/ScoreTab.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Certificate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.score),
            label: 'Score',
          ),
        ],
         backgroundColor: Colors.grey[100],
          type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
          elevation: 10,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ProfileTab();
      case 1:
        return CertificateTab();
      case 2:
        return ChatTab();
      case 3:
        return ScoreTab();
      default:
        return ProfileTab();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}