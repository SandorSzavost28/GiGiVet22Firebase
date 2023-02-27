import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigivet22firebase/screens/all_screens.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MainMenuScreen extends StatefulWidget {

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {

  int _selectedIndex = 0;
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  

  //Lista de Paginas en Pagevireew
  static final List<Widget> _widgetOptions = <Widget>[
    
    HomeScreen(),

    PetListScreen(),
    
    // Search_1_Screen(),

    Test1Screen(),

    Profile1_Screen(),


  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        elevation: 20,
        title: const Text('Gigi22 Firebase'),
        backgroundColor: Color(0xff392850),
        // backgroundColor: Colors.amber[600],
      ),
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            
            child: GNav(
              // rippleColor: Colors.grey[300]!,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.paw,
                  text: 'Pets',
                ),
                // GButton(
                //   icon: LineIcons.search,
                //   text: 'Search',
                // ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            
          ),
        ),
      ),
    );
  }
}