import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content_loading.dart';

class NuggetCard extends StatelessWidget {
  const NuggetCard({super.key, required this.video});
  final Video video;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(video.thumbnail),
      title: Text(video.title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NuggetCardToMainContentLoader(video: video),
        ));
      },
    );
  }
}

class NuggetCardToMainContentLoader extends ConsumerStatefulWidget {
  const NuggetCardToMainContentLoader({super.key, required this.video});
  final Video video;

  @override
  ConsumerState<NuggetCardToMainContentLoader> createState() =>
      _NuggetCardToMainContentLoaderState();
}

class _NuggetCardToMainContentLoaderState
    extends ConsumerState<NuggetCardToMainContentLoader> {
  Nugget? nugget;
  bool error = false;

  @override
  void initState() {
    super.initState();
    loadNugget();
  }

  loadNugget() async {
    nugget = await ref
        .read(videoRepositoryProvider)
        .getNuggetFromVideo(video: widget.video);
    if (nugget == null) {
      error = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (nugget == null)
          ? (error)
              ? const Center(
                  child: Text(
                    'Unfortunately the nugget for this video is not available at the moment!',
                    softWrap: true,
                  ),
                )
              : const MainContentLoading()
          : MainContent(nugget: nugget!),
    );
  }
}
