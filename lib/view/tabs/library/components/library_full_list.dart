import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/access_token.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:nugget_berg/view/components/nugget_card.dart';

class LibraryFullList extends ConsumerStatefulWidget {
  final String title;
  final List<String> videos;
  const LibraryFullList({super.key, required this.title, required this.videos});

  @override
  ConsumerState<LibraryFullList> createState() => _LibraryFullListState();
}

class _LibraryFullListState extends ConsumerState<LibraryFullList> {
  List<Video>? videosList;

  loadVideos() async {
    final videoRepo = ref.read(videoRepositoryProvider);
    final accessToken = await ref.read(accessTokenProvider.future);
    videosList = [];
    for (var i = 0; i < widget.videos.length; i++) {
      final video = await videoRepo.getVideoById(
          id: widget.videos[i], accessToken: accessToken!);
      
      if(video != null) {
        videosList!.add(video);
      }
    }
    print(videosList);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadVideos();
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
        body: (videosList == null || videosList!.isEmpty)
            ? Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey,
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: videosList!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: NuggetCard(
                    video: videosList![index],
                  ),
                ),
              ),
      ),
    );
  }
}
