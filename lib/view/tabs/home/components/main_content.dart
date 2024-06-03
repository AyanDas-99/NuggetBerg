import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/nuggets/providers/nugget_by_video_id.dart';
import 'package:nugget_berg/view/tabs/home/components/dot_indicator.dart';
import 'package:nugget_berg/view/tabs/home/components/key_point_widget.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content_loading.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class MainContent extends ConsumerStatefulWidget {
  const MainContent({super.key});

  @override
  ConsumerState<MainContent> createState() => _MainContentState();
}

class _MainContentState extends ConsumerState<MainContent> {
  final carouselController = CarouselController();
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final nugget = ref.watch(NuggetByVideoIdProvider('8ZqGzlQ6xtI'));
    return nugget.when(
        data: (nugget) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOU4ZwXLhqyebgok9yT4o0-vskE_hwEvZDtA&usqp=CAU',
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'How to get rich in your 20s',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          height: MediaQuery.of(context).size.height * 0.43,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              selected = index;
                            });
                          },
                        ),
                        items: [
                          ...nugget.points.map((e) => KeyPointWidget(point: e))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            nugget.points.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: DotIndicator(
                                isActive: index == selected,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.heart),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(CupertinoIcons.bookmark_fill),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  Transform.rotate(
                      angle: math.pi / 2,
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.blueGrey.shade100,
                          direction: ShimmerDirection.btt,
                          child: Icon(CupertinoIcons.chevron_left_2)))
                ],
              ),
            ),
        error: (e, st) => Center(
              child: Text(e.toString()),
            ),
        loading: () => const MainContentLoading());
  }
}
