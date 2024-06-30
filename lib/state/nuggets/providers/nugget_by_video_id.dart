import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'nugget_by_video_id.g.dart';


@riverpod
Future<Nugget?> nuggetByVideo(NuggetByVideoRef ref, Video video) async{
  return await ref.read(videoRepositoryProvider).getNuggetFromVideo(video: video);
} 