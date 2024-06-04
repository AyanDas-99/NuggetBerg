import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/state/nuggets/providers/nugget_by_video_id.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/videos.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  int currentIndex = 0;

  List<Video>? videos;
  List<Nugget> nuggets = [];

  List<int> a = [];

  _handlePageChange(int current) {
    currentIndex = current;
    setState(() {});
    getNextNuggetOrRemoveVideo();
  }

  loadVideos() async {
    videos = await ref.read(videoProvider.notifier).updateList();
    if (videos == null) return;
    Nugget? first;
    while (first == null && videos!.isNotEmpty) {
      first = await ref.read(nuggetByVideoIdProvider(videos!.first.id).future);
      if (first == null) {
        videos?.remove(videos?.first);
      }
    }
    if (first != null) {
      print('First one done');
      nuggets.add(first);
    }
    setState(() {});
    getNextNuggetOrRemoveVideo();
    print(nuggets);
  }

  getNextNuggetOrRemoveVideo() async {
    int nextIndex = currentIndex + 1;
    if (videos!.length < nextIndex) return;
    Nugget? next;
    while (next == null && videos!.isNotEmpty) {
      next =
          await ref.read(nuggetByVideoIdProvider(videos![nextIndex].id).future);
      if (next == null) {
        videos?.removeAt(nextIndex);
      }
    }
    if (next != null) {
      nuggets.add(next);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: (videos == null)
          ? const MainContentLoading()
          : PageView.builder(
              onPageChanged: (current) => _handlePageChange(current),
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos!.length,
              itemBuilder: (BuildContext context, int index) {
                return MainContent(video: videos![currentIndex], nugget: nuggets[currentIndex]);
              },
            ),
    );
  }
}
