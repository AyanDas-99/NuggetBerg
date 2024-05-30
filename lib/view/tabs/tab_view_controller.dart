import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/home/home_screen.dart';

class TabViewController extends StatefulWidget {
  const TabViewController({super.key});

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  final tabs = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: forYou,
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(CupertinoIcons.search_circle),
      label: explore,
      selectedIcon: Icon(
        CupertinoIcons.search_circle_fill,
      ),
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_border_rounded),
      label: myLibrary,
      selectedIcon: Icon(Icons.bookmark),
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      label: settings,
      selectedIcon: Icon(Icons.settings),
    ),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 206, 177, 181),
            Color(0xFFffdde1),
          ],
        ),
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          destinations: tabs,
          selectedIndex: selected,
          onDestinationSelected: (value) {
            setState(() {
              selected = value;
            });
          },
        ),
        body: Column(
          children: [
            Expanded(child: (selected == 0) ? HomeScreen() : Container()),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
