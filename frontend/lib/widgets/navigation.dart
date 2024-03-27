import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:snappio/screens/tabs/chats.dart';
import 'package:snappio/screens/tabs/posts.dart';
import 'package:snappio/screens/tabs/profile.dart';
import 'package:snappio/screens/tabs/search.dart';

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
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          if (index == 2) {
            _selectedIndex < index ? index++ : index--;
            setState(() {
              _pageController.jumpToPage(index);
              _selectedIndex = index;
            });
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        children: [
          const PostsFeed(),
          const ChatSection(),
          Scaffold(appBar: AppBar(), body: Container()),
          const SearchUser(),
          const ProfilePage()]
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: Durations.extralong2,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          index == 2 ?
          Navigator.pushNamed(context, '/upload') :
          setState(() {
          _selectedIndex = index;
          _pageController.jumpToPage(index);
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Ionicons.image_outline,
              size: 35,
              color: Theme.of(context).iconTheme.color,
            ),
            selectedIcon: Icon(
              Ionicons.images,
              size: 35,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            label: 'Posts',
          ),
          NavigationDestination(
            icon: Icon(
              Ionicons.chatbubble_outline,
              size: 35,
              color: Theme.of(context).iconTheme.color,
            ),
            selectedIcon: Icon(
              Ionicons.chatbubble_ellipses,
              size: 35,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            label: 'Chats',
          ),
          const NavigationDestination(icon: Icon(Icons.abc, size: 0),label: ''),
          NavigationDestination(
            icon: Icon(
              Ionicons.search,
              size: 35,
              color: Theme.of(context).iconTheme.color,
            ),
            selectedIcon: Icon(
              Ionicons.at,
              size: 35,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(
              Ionicons.person_circle_outline,
              size: 35,
              color: Theme.of(context).iconTheme.color,
            ),
            selectedIcon: Icon(
              Ionicons.person,
              size: 35,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 80,
        width: 80,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).canvasColor,
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/upload'),
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          shape: const CircleBorder(eccentricity: 1),
          child: Icon(Ionicons.add,
            size: 37,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
      ),
    );
  }
}
