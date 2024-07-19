import 'dart:math' show min;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/access_token.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/components/nugget_card.dart';
import 'package:nugget_berg/view/tabs/library/components/library_full_list.dart';
import 'dart:developer' as dev;

import 'package:shimmer/shimmer.dart';

class Section extends ConsumerStatefulWidget {
  final String section;
  final List<String> videosIds;
  const Section({super.key, required this.section, required this.videosIds});

  @override
  ConsumerState<Section> createState() => _SectionState();
}

class _SectionState extends ConsumerState<Section> {
  List<Video>? videosList;
  final int showCount = 3;

  loadVideos() async {
    // Get only 2 videos
    final videos =
        widget.videosIds.sublist(0, min(widget.videosIds.length, showCount));

    try {
      final videoRepo = ref.read(videoRepositoryProvider);
      final accessToken = await ref.read(accessTokenProvider.future);
      videosList = [];
      for (var i = 0; i < videos.length; i++) {
        final video = await videoRepo.getVideoById(
            id: videos[i], accessToken: accessToken!);

        if (video != null) {
          videosList!.add(video);
        }
      }
      setState(() {});
    } catch (e) {
      dev.log("Error in loadVideos | library_full_list.dart", error: e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.section,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        if (videosList == null)
          ...List.generate(
              showCount,
              (index) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade400,
                    child: ListTile(
                      leading:
                          Container(width: 50, height: 50, color: Colors.black),
                      title: Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.black),
                    ),
                  ))
        else ...[
          ...List.generate(
            videosList!.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: NuggetCard(
                video: videosList![index],
              ),
            ),
          ),
          if (videosList!.length < widget.videosIds.length)
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LibraryFullList(
                    title: widget.section,
                    videos: widget.videosIds,
                  ),
                ));
              },
              child: Text(
                showMore,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            )
        ],
      ],
    );
  }
}
