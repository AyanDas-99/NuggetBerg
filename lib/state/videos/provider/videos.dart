import 'package:nugget_berg/state/auth/providers/access_token.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/next_page_token.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer' as dev;
part 'videos.g.dart';

@Riverpod(keepAlive: true)
class VideoProvider extends _$VideoProvider {
  @override
  List<Video> build() {
    return [];
  }

  Future<List<Video>> updateList() async {
    // token
    final token = await ref.read(accessTokenProvider.future);
    if (token == null) return [];
    // video repository
    var videoRepository = ref.read(videoRepositoryProvider);
    var videosAndNextPageToken = await videoRepository.getVideos(
        accessToken: token, nextPageToken: ref.read(nextPageTokenProvider));
    state = [...state, ...videosAndNextPageToken.videos];
    dev.log('Videos state set as $state');
    //setting next page token
    ref
        .read(nextPageTokenProvider.notifier)
        .update(videosAndNextPageToken.nextPageToken);
    return state;
  }

  void removeAt(int index) {
    final list = state;
    try {
      list.removeAt(index);

      state = list;
    } catch (e) {
      dev.log('Cannot remove element at $index from $list', error: e);
    }
  }
}
