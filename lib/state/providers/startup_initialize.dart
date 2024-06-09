import 'package:nugget_berg/state/auth/providers/user.dart';
import 'package:nugget_berg/state/videos/provider/videos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'startup_initialize.g.dart';

@Riverpod(keepAlive: true)
FutureOr<void> startupInitilize(StartupInitilizeRef ref) async {
  await ref.read(mongoUserProvider.notifier).getUser();
  final videos = await ref.read(videoProviderProvider.notifier).updateList();
}
