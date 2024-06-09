import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/user.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/view/tabs/home/components/dot_indicator.dart';
import 'package:nugget_berg/view/tabs/home/components/key_point_widget.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';

class MainContent extends ConsumerStatefulWidget {
  final Nugget nugget;
  const MainContent({
    super.key,
    required this.nugget,
  });

  @override
  ConsumerState<MainContent> createState() => _MainContentState();
}

class _MainContentState extends ConsumerState<MainContent> {
  final carouselController = CarouselController();
  int selected = 0;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    ref.read(mongoUserProvider.notifier).addToViewed(widget.nugget.video.id);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(mongoUserProvider);
    final favourites = user?.favourites.map((e) => e['video_id']) ?? [];
    isFav = favourites.contains(widget.nugget.video.id);

    return Padding(
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
                  widget.nugget.video.thumbnail,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.nugget.video.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * 0.35,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selected = index;
                    });
                  },
                ),
                items: [
                  ...widget.nugget.points.map((e) => KeyPointWidget(point: e))
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    widget.nugget.points.length,
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
                    icon: (isFav == true)
                        ? const Icon(CupertinoIcons.heart_fill,
                            color: Colors.red)
                        : const Icon(CupertinoIcons.heart),
                    onPressed: () {
                      ref
                          .read(mongoUserProvider.notifier)
                          .addToFavourite(widget.nugget.video.id);
                          setState(() {
                            isFav = !isFav;
                          });
                    },
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.bookmark_fill),
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
                  child: const Icon(CupertinoIcons.chevron_left_2)))
        ],
      ),
    );
  }
}
