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

  loadVideos() async {
    // Get only 2 videos
    final videos = widget.videosIds.sublist(0, min(widget.videosIds.length, 2));

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
      print(videosList);
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
      children: (videosList == null)
          ? List.generate(
              2,
              (index) => Shimmer.fromColors(
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
                  ))
          : [
              Text(
                widget.section,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              ...List.generate(
                videosList!.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: NuggetCard(
                    video: videosList![index],
                  ),
                ),
              ),
              if(videosList!.length < widget.videosIds.length)
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
    );
  }
}
