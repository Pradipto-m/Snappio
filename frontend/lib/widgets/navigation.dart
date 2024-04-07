import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:snappio/screens/tabs/chats.dart';
import 'package:snappio/screens/tabs/posts.dart';
import 'package:snappio/screens/tabs/profile.dart';
import 'package:snappio/screens/tabs/snaps.dart';

class NavBar extends StatefulWidget {
  static const String routeName = '/navigation';
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  static int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: const [
          ChatSection(),
          PostsFeed(),
          SnapsPage(),
          ProfilePage()]
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(top: 2, bottom: 7, left: 7, right: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
          color: Theme.of(context).cardColor.withOpacity(0.33),
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          tabBorderRadius: 32, 
          tabBackgroundColor: Theme.of(context).cardColor,
          color: Theme.of(context).highlightColor.withOpacity(0.8),
          activeColor: Theme.of(context).highlightColor,
          iconSize: 32,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
          gap: 9,
          curve: Curves.easeOut,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            int diff = index - _selectedIndex;
            diff.abs() > 1 ? 
            _pageController.jumpToPage(index) :
            _pageController.animateToPage(
              index,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
            );
            setState(() => _selectedIndex = index);
          },
          tabs: [
            GButton(
              icon: _selectedIndex == 0 ? Ionicons.chatbubble_ellipses : Ionicons.chatbubble_ellipses_outline,
              text: 'Chats',
            ),
            GButton(
              icon: _selectedIndex == 1 ? Ionicons.image : Ionicons.image_outline,
              text: 'Posts',
            ),
            GButton(
              icon: _selectedIndex == 2 ? Ionicons.play : Ionicons.play_outline,
              text: 'Snaps',
            ),
            GButton(
              icon: _selectedIndex == 3 ? Ionicons.person : Ionicons.person_outline,
              text: 'Profile',
            ),
          ],
        ),
      )
    );
  }
}
