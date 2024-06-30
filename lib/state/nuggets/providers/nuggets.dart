import 'package:nugget_berg/state/auth/providers/user.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/state/nuggets/providers/nugget_by_video_id.dart';
import 'package:nugget_berg/state/videos/provider/next_page_token.dart';
import 'package:nugget_berg/state/videos/provider/videos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer' as dev;
part 'nuggets.g.dart';

@riverpod
class Nuggets extends _$Nuggets {

  @override
  List<Nugget> build() {
    return [];
  }

  loadNuggets() async {
    print('Loading videos');
    final videos = ref.read(videoProviderProvider);
    final videosNotifier = ref.read(videoProviderProvider.notifier);

    Nugget? first;
    while (first == null && videos.isNotEmpty) {
      first = await ref.read(nuggetByVideoProvider(videos.first).future);
      if (first == null) {
        videosNotifier.removeAt(0);
      }
    }
    if (first != null) {
      print('First one done');
      state = [first];
      print(state);
    }
    getNextNuggetOrRemoveVideo(currentIndex: 0);
  }

  getNextNuggetOrRemoveVideo({required int currentIndex}) async {
    print('Get next called');
    final videos = ref.read(videoProviderProvider);
    final videosNotifier = ref.read(videoProviderProvider.notifier);
    int nextIndex = currentIndex + 1;
    print('Videos length: ${videos.length}');
    print('NextIndex: $nextIndex');

    if (videos.length <= nextIndex) {
      print('No more videos to show for');
      getNextPage(currentIndex);
      return;
    }
    Nugget? next;

    try {
      while (next == null && videos.isNotEmpty) {
        next = await ref.read(nuggetByVideoProvider(videos[nextIndex]).future);
        if (next == null) {
          videosNotifier.removeAt(nextIndex);
        }
      }
    } on RangeError catch (e) {
      dev.log('Error getting next nugget', error: e);
      getNextPage(currentIndex);
      return;
    } on Exception catch (e) {
      dev.log('Error getting next nugget', error: e);
    }
    if (next != null) {
      state = [...state, next];
      print(state);
    }
  }

  getNextPage(int currentIndex) async {
    dev.log('Getting next page');
    String? nextPage = ref.read(nextPageTokenProvider);
    await ref.read(mongoUserProvider.notifier).setNextPageToken(nextPage);
    await ref.read(videoProviderProvider.notifier).updateList();
    getNextNuggetOrRemoveVideo(currentIndex: currentIndex);
  }
}
