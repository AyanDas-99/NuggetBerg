import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/access_token.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:nugget_berg/view/components/nugget_card.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as dev;

class LibraryFullList extends ConsumerStatefulWidget {
  final String title;
  final List<String> videos;
  const LibraryFullList({super.key, required this.title, required this.videos});

  @override
  ConsumerState<LibraryFullList> createState() => _LibraryFullListState();
}

class _LibraryFullListState extends ConsumerState<LibraryFullList> {
  late ScrollController controller;
  bool hasMore = true;
  bool isLoading = false;

  List<Video>? videosList;

  loadVideos(int start) async {
    if (isLoading) return;
    isLoading = true;
    try {
      final videoRepo = ref.read(videoRepositoryProvider);
      final accessToken = await ref.read(accessTokenProvider.future);
      if (start + 10 > widget.videos.length) {
        hasMore = false;
      }
      final extent = min(widget.videos.length, start + 10);
      for (var i = start; i < extent; i++) {
        final video = await videoRepo.getVideoById(
            id: widget.videos[i], accessToken: accessToken!);

        if (video != null) {
          videosList!.add(video);

          print(videosList);
          setState(() {});
        }
      }
    } catch (e) {
      dev.log("Error in loadVideos | library_full_list.dart", error: e);
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    videosList = [];
    loadVideos(0);
    controller.addListener(() {
      if (hasMore) {
        if (controller.position.maxScrollExtent == controller.offset) {
          loadVideos(videosList!.length);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w200),
          ),
        ),
        body: (videosList == null)
            ? Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            : ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(16),
                itemCount: videosList!.length + 1,
                itemBuilder: (context, index) {
                  if (index < videosList!.length) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: NuggetCard(
                        video: videosList![index],
                      ),
                    );
                  } else {
                    if (hasMore) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
      ),
    );
  }
}
