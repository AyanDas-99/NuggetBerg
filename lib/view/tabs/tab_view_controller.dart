import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/settings/providers/settings.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/home/home_screen.dart';
import 'package:nugget_berg/view/tabs/library/library_screen.dart';
import 'package:nugget_berg/view/tabs/settings/settings_screen.dart';
import 'package:nugget_berg/view/theme/constants/profiles.dart';

class TabViewController extends ConsumerStatefulWidget {
  const TabViewController({super.key});

  @override
  ConsumerState<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends ConsumerState<TabViewController> {
  final tabs = <NavigationDestination>[
    NavigationDestination(
      icon: const Icon(Icons.home_outlined),
      label: forYou,
      selectedIcon: const Icon(Icons.home),
    ),
    NavigationDestination(
      icon: const Icon(Icons.bookmark_border_rounded),
      label: myLibrary,
      selectedIcon: const Icon(Icons.bookmark),
    ),
    NavigationDestination(
      icon: const Icon(Icons.settings_outlined),
      label: settings,
      selectedIcon: const Icon(Icons.settings),
    ),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final appProfiles =
        ref.watch(settingsProvider.select((setting) => setting?.profile)) ??
            allAppProfiles.first;
    return Container(
      decoration: BoxDecoration(
        gradient: appProfiles.gradient,
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
