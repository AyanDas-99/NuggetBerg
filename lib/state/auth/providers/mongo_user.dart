import 'package:nugget_berg/state/auth/models/user.dart' as user_model;
import 'package:nugget_berg/state/auth/providers/mongo_user_repository.dart';
import 'package:nugget_berg/state/videos/provider/next_page_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mongo_user.g.dart';

@Riverpod(keepAlive: true)
class MongoUser extends _$MongoUser {
  @override
  user_model.User? build() {
    getUser();
    return null;
  }

  Future getUser() async {
    final mongoUserRepository = ref.read(mongoUserRepositoryProvider);
    final user = await mongoUserRepository.getUser();
    // Setting next page token
    ref.read(nextPageTokenProvider.notifier).update(user?.nextPage);
    if (user != null) {
      state = user;
    }
  }

  Future setNextPageToken(String? nextPage) async {
    final mongoUserRepository = ref.read(mongoUserRepositoryProvider);
    final user = await mongoUserRepository.setNextPageToken(nextPage);
    if (user != null) {
      state = user;
    }
  }

  Future addToFavourite(String videoId) async {
    final mongoUserRepository = ref.read(mongoUserRepositoryProvider);
    final user = await mongoUserRepository.addToFavourite(videoId);
    if (user != null) {
      state = user;
    }
  }

  Future addToViewed(String videoId) async {
    final mongoUserRepository = ref.read(mongoUserRepositoryProvider);
    final user = await mongoUserRepository.addToViewed(videoId);
    if (user != null) {
      state = user;
    }
  }
}
