import 'package:flutter_test/flutter_test.dart';
import 'package:nugget_berg/state/auth/providers/access_token.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
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

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

// Mocks
class MockVideoRepository extends Mock implements VideoRepository {}

void main() {
  late MockVideoRepository? mockVideoRepository;

  setUp(() {
    mockVideoRepository = MockVideoRepository();
  });

  final videosFromPage1 = [
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
  final videosFromPage2 = [
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
        id: '6',
        channelId: '',
        title: 'video 7',
        description: 'video 7 desc',
        thumbnail: '',
        channelTitle: ''),
    Video(
        id: '7',
        channelId: '',
        title: 'video 8',
        description: 'video 8 desc',
        thumbnail: '',
        channelTitle: ''),
  ];

  void videoRepoReturnsVideos() {
    when(() => mockVideoRepository!.getVideos(accessToken: 'token'))
        .thenAnswer((annotation) async {
      return videosFromPage1;
    });
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
      })
    ]);
  }

  test('videoProvider updates using VideoRepository', () async {
    videoRepoReturnsVideos();
    final container = createContainerWithoverrides();
    await container.read(videoProviderProvider.notifier).updateList();
    final videos = container.read(videoProviderProvider);
    expect(videos, videosFromPage1);
  });

  test('Videos list based on page token', (){
    videoRepoReturnsVideos();
  });
}
