import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/videos/provider/videos.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(videoProvider.notifier).updateList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final videos = ref.watch(videoProvider);
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
        items: videos.map((e) => MainContent(e)).toList(),
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
