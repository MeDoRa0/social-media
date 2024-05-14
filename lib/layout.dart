import 'package:flutter/material.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/pages/add.dart';
import 'package:social_media/pages/home.dart';
import 'package:social_media/pages/profile.dart';
import 'package:social_media/pages/search.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //pageview to enable user to navigate between pages by swip
      body: PageView(
        controller: pageController,
        children: const [
          HomePage(),
          AddPage(),
          SearchPage(),
          ProfilePage(),
        ],
        //this will make each icon in bottom bar highlieted when its page is open
        onPageChanged: (value) => setState(
          () {
            currentIndex = value;
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        backgroundColor: kPrimaryColor.withOpacity(0.1),
        onDestinationSelected: (value) => setState(
          () {
            currentIndex = value;
            pageController.jumpToPage(value);
          },
        ),
        selectedIndex: currentIndex,
        indicatorColor: kSecondryColor.withOpacity(0.2),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_filled),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home_filled,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.add),
            label: 'Add',
            selectedIcon: Icon(
              Icons.add,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: 'Search',
            selectedIcon: Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: 'Profile',
            selectedIcon: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
