import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final String query;
  const SearchView({super.key, required this.query});

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
            query,
            style: const TextStyle(fontWeight: FontWeight.w200),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.only(bottom: 8.0),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
