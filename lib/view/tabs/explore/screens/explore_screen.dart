import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'dart:math' as math;

import 'package:nugget_berg/view/tabs/explore/components/search_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final demoSubs = [
    'Phychlogy',
    'Business',
    'Technology',
    'History',
    'Society',
  ];

  final searchContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          explore,
          style: const TextStyle(fontWeight: FontWeight.w200),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchBar(
            controller: searchContrller,
            backgroundColor: const WidgetStatePropertyAll(Colors.white54),
            hintText: searchFor,
            leading: const Icon(Icons.search),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onSubmitted: (value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchView(query: searchContrller.text),
              ));
            },
          ),
          const SizedBox(height: 20),
          Text(
            categories,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              children: List.generate(
                demoSubs.length,
                (index) {
                  final sub = demoSubs[index];
                  final color =
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0);
                  return Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          color.withAlpha(80),
                          color.withAlpha(130),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      sub,
                      style: const TextStyle(fontWeight: FontWeight.w200),
                    )),
                  );
                },
              )),
        ],
      ),
    );
  }
}
