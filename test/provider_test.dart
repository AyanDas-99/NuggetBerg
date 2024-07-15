import 'package:flutter_test/flutter_test.dart';
import 'package:nugget_berg/state/auth/models/user.dart';
import 'package:nugget_berg/state/auth/providers/access_token.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user_repository.dart';
import 'package:nugget_berg/state/auth/repositories/mongo_user_repository.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/state/nuggets/providers/nugget_by_video_id.dart';
import 'package:nugget_berg/state/nuggets/providers/nuggets.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/next_page_token.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:nugget_berg/state/videos/provider/videos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.

import 'package:nugget_berg/state/videos/repositories/video_repository.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  return container;
}

// Mocks
class MockVideoRepository extends Mock implements VideoRepository {
  @override
  Future<Nugget?> getNuggetFromVideo({required Video video}) async {
    if (video.id == '2') return null;
    return Nugget(video: video, points: const []);
  }
}

class MockMongoUserRepository extends Mock implements MongoUserRepository {
  @override
  Future<User?> getUser() async {
    return const User(id: 'id', email: 'email', favourites: [], viewed: []);
  }
}

void main() {
  late MockVideoRepository? mockVideoRepository;
  late MockMongoUserRepository? mockMongoUserRepository;

  setUp(() {
    mockVideoRepository = MockVideoRepository();
    mockMongoUserRepository = MockMongoUserRepository();
  });

  const videosFromPage1 = [
    Video(
        id: '0',
        channelId: '',
        title: 'video 1',
        description: 'video 1 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '1',
        channelId: '',
        title: 'video 1',
        description: 'video 1 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '2',
        channelId: '',
        title: 'video 2',
        description: 'video 2 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '3',
        channelId: '',
        title: 'video 3',
        description: 'video 3 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '4',
        channelId: '',
        title: 'video 4',
        description: 'video 4 desc',
        thumbnail: '',
        channelTitle: ''),
  ];
  const videosFromPage2 = [
    Video(
        id: '5',
        channelId: '',
        title: 'video 5',
        description: 'video 5 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '6',
        channelId: '',
        title: 'video 6',
        description: 'video 6 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '7',
        channelId: '',
        title: 'video 7',
        description: 'video 7 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '8',
        channelId: '',
        title: 'video 8',
        description: 'video 8 desc',
        thumbnail: '',
        channelTitle: ''),
  ];

  final nuggetsFromPage1 =
      videosFromPage1.map((e) => Nugget(video: e, points: const [])).toList();
  final nuggetsFromPage2 =
      videosFromPage2.map((e) => Nugget(video: e, points: const [])).toList();

  void videoRepoReturnsVideos() {
    when(() => mockVideoRepository!.getVideos(
          accessToken: 'token',
        )).thenAnswer((annotation) async {
      return const VideosAndNextPageToken(
          videos: videosFromPage1, nextPageToken: '2');
    });
    when(() => mockVideoRepository!.getVideos(
        accessToken: 'token',
        nextPageToken: '1')).thenAnswer((annotation) async {
      return const VideosAndNextPageToken(
          videos: videosFromPage1, nextPageToken: '2');
    });
    when(() => mockVideoRepository!.getVideos(
        accessToken: 'token',
        nextPageToken: '2')).thenAnswer((annotation) async {
      return const VideosAndNextPageToken(
          videos: videosFromPage2, nextPageToken: '3');
    });
  }

  void mongoUserRepositorySetup() {
    when(() => mockMongoUserRepository!.setNextPageToken('2')).thenAnswer(
        (_) async => const User(
            id: '', email: 'email', favourites: [], viewed: [], nextPage: '2'));
    when(() => mockMongoUserRepository!.setNextPageToken(null))
        .thenAnswer((_) async => null);
  }

  ProviderContainer createContainerWithoverrides() {
    return createContainer(overrides: [
      // accesstoken
      accessTokenProvider.overrideWith((ref) {
        return Future<String?>.value('token');
      }),
      // video repo getVideos
      videoRepositoryProvider.overrideWith((ref) {
        return mockVideoRepository!;
      }),
      // mongo user repository provider
      mongoUserRepositoryProvider.overrideWith((ref) {
        return mockMongoUserRepository!;
      })
    ]);
  }

  group('All mocks work as expected', () {
    test('Testing providers without any method run', () async {
      videoRepoReturnsVideos();
      final container = createContainerWithoverrides();
      await container.read(videoProviderProvider.notifier).updateList();
      final videos = container.read(videoProviderProvider);
      final accessToken = await container.read(accessTokenProvider.future);
      final nextPageToken = container.read(nextPageTokenProvider);
      expect(videos, videosFromPage1);
      expect(accessToken, 'token');
      expect(nextPageToken, '2');
    });

    test('Video repository returns videos based on accesstoken', () async {
      videoRepoReturnsVideos();
      final container = createContainerWithoverrides();

      final video1 = await container
          .read(videoRepositoryProvider)
          .getVideos(accessToken: 'token', nextPageToken: '1');
      expect(video1, videosFromPage1);
      final video2 = await container
          .read(videoRepositoryProvider)
          .getVideos(accessToken: 'token', nextPageToken: '2');
      expect(video2, videosFromPage2);
    });

    test('videoProvider updates using VideoRepository', () async {
      videoRepoReturnsVideos();
      final container = createContainerWithoverrides();
      container.read(nextPageTokenProvider.notifier);
      // final accessToken = await container.read(accessTokenProvider.future);
      // final nextPageToken = container.read(nextPageTokenProvider);

      await container.read(videoProviderProvider.notifier).updateList();
      final videos = container.read(videoProviderProvider);
      print(videos);
      expect(videos, videosFromPage1);
    });
  });

  group('Nuggets provider working', () {
    test('Nugget by video provider returns', () async {
      videoRepoReturnsVideos();
      final container = createContainerWithoverrides();
      final nugget = await container
          .read(NuggetByVideoProvider(videosFromPage1.first).future);
      expect(nugget, Nugget(video: videosFromPage1.first, points: const []));
    });

    test('Nugget provider works', () async {
      videoRepoReturnsVideos();
      mongoUserRepositorySetup();
      final container = createContainerWithoverrides();
      await container.read(videoProviderProvider.notifier).updateList();
      final nuggetsSub = container.listen(nuggetsProvider, (_, __) {});
      final nuggetNotifier = container.read(nuggetsProvider.notifier);
      // Empty nuggets without loadVideos()
      expect(nuggetsSub.read(), []);

      // loadVideos() called should first 2 nuggets
      await nuggetNotifier.loadNuggets();

      // Nuggets from page one
      await Future.delayed(const Duration(milliseconds: 500));

      expect(nuggetsSub.read(), [nuggetsFromPage1.first, nuggetsFromPage1[1]]);

      await nuggetNotifier.getNextNuggetOrRemoveVideo(currentIndex: 1);

      expect(nuggetsSub.read(), nuggetsFromPage1.sublist(0, 3));

      await nuggetNotifier.getNextNuggetOrRemoveVideo(currentIndex: 2);

      expect(nuggetsSub.read(), nuggetsFromPage1.sublist(0, 4));

      await nuggetNotifier.getNextNuggetOrRemoveVideo(currentIndex: 3);

      expect(nuggetsSub.read(), nuggetsFromPage1.sublist(0, 5));

      await nuggetNotifier.getNextNuggetOrRemoveVideo(currentIndex: 4);
      expect(nuggetsSub.read(), [...nuggetsFromPage1]);
    });
  });

  test('Testing get next page', () async {
    videoRepoReturnsVideos();
    mongoUserRepositorySetup();
    final container = createContainerWithoverrides();
    await container.read(videoProviderProvider.notifier).updateList();
    final nuggetsSub = container.listen(nuggetsProvider, (_, __) {});
    await container.read(nuggetsProvider.notifier).loadNuggets();
    await Future.delayed(const Duration(seconds: 1));
    for (var i = 1; i < 4; i++) {
      await container
          .read(nuggetsProvider.notifier)
          .getNextNuggetOrRemoveVideo(currentIndex: i);
    }
    expect(nuggetsSub.read(), nuggetsFromPage1);
    await container
        .read(nuggetsProvider.notifier)
        .getNextNuggetOrRemoveVideo(currentIndex: 4);
    await Future.delayed(const Duration(seconds: 1));
    expect(nuggetsSub.read(), [...nuggetsFromPage1, nuggetsFromPage2.first]);

    container.dispose();
  });

  test('all nuggets from 2 pages loading', () async {
    videoRepoReturnsVideos();
    mongoUserRepositorySetup();
    final container = createContainerWithoverrides();
    await container.read(videoProviderProvider.notifier).updateList();
    final nuggetsSub = container.listen(nuggetsProvider, (_, __) {});
    await container.read(nuggetsProvider.notifier).loadNuggets();
    await Future.delayed(const Duration(seconds: 1));
    for (var i = 1; i < 7; i++) {
      await container
          .read(nuggetsProvider.notifier)
          .getNextNuggetOrRemoveVideo(currentIndex: i);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    expect(
        nuggetsSub.read(),
        nuggetsFromPage1.where((ngt) => ngt.video.id != '2').toList() +
            nuggetsFromPage2);
  });
}
