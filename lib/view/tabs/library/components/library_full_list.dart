import 'package:flutter/material.dart';
import 'package:nugget_berg/view/components/nugget_card.dart';

class LibraryFullList extends StatelessWidget {
  final String title;
  const LibraryFullList({super.key, required this.title});

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w200),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 10,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: NuggetCard(),
          ),
        ),
      ),
    );
  }
}
