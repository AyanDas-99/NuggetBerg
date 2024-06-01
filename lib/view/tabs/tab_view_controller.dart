import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/explore/screens/explore_screen.dart';
import 'package:nugget_berg/view/tabs/home/home_screen.dart';
import 'package:nugget_berg/view/tabs/library/library_screen.dart';
import 'package:nugget_berg/view/tabs/settings/settings_screen.dart';
import 'package:nugget_berg/view/theme/app_gradient.dart';

class TabViewController extends ConsumerStatefulWidget {
  const TabViewController({super.key});

  @override
  ConsumerState<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends ConsumerState<TabViewController> {
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
    final appGradient = ref.watch(appGradientProvider);
    return Container(
      decoration: BoxDecoration(
        gradient: appGradient,
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
            Expanded(
                child: [
              const HomeScreen(),
              const ExploreScreen(),
              const LibraryScreen(),
              const SettingsScreen()
            ][selected]),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}