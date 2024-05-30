import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          home,
          style: const TextStyle(fontWeight: FontWeight.w200),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
          child: CarouselSlider(
        items: [
          Container(
            child: Center(child: MainContent()),
          ),
          Container(
            child: Center(child: MainContent()),
          ),
          Container(
            child: Center(child: MainContent()),
          ),
        ],
        options: CarouselOptions(
          height: size.height,
          scrollDirection: Axis.vertical,
          viewportFraction: 1,
          enableInfiniteScroll: false,
        ),
      )),
    );
  }
}
