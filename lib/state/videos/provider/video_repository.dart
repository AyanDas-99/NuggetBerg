import 'package:nugget_berg/state/videos/repositories/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository.g.dart';

@riverpod
VideoRepository videoRepository(VideoRepositoryRef ref) {
  return VideoRepository();
}