import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/tab_view_controller.dart';

class InterestSelectionScreen extends StatefulWidget {
  const InterestSelectionScreen({super.key});

  @override
  State<InterestSelectionScreen> createState() =>
      _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  final demoSubs = [
    'Phychlogy',
    'Business',
    'Technology',
    'History',
    'Society',
  ];

  final selected = [];

  proceed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const TabViewController(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.blue),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          onPressed: proceed,
          child: const Text(
            'Proceed',
            style: TextStyle(color: Colors.white),
          )),
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Text(
            whatAre,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          const SizedBox(height: 20),
          Text(wellUse),
          const SizedBox(height: 20),
          ...demoSubs.map((sub) => ListTile(
                onTap: () {
                  if (selected.contains(sub)) {
                    selected.remove(sub);
                  } else {
                    selected.add(sub);
                  }

                  setState(() {});
                },
                title: Text(sub),
                trailing: Checkbox(
                  value: selected.contains(sub),
                  onChanged: (value) {
                    if (value == true) {
                      selected.add(sub);
                    } else {
                      selected.remove(sub);
                    }
                    setState(() {});
                  },
                ),
              ))
        ],
      ),
    );
  }
}
