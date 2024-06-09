import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nugget_berg/state/auth/providers/user.dart';
import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/state/videos/provider/next_page_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
part 'videos.g.dart';

@Riverpod(keepAlive: true)
class VideoProvider extends _$VideoProvider {
  @override
  List<Video> build() {
    return [];
  }

  Future<List<Video>> updateList() async {
    final user = ref.read(mongoUserProvider);
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    if (token == null || user == null) return [];
    final query = (user.nextPage != null) ? '?nextPage=${user.nextPage!}' : '';
    var response = await http.get(
      Uri.parse('${Constants.baseUrl}/videos$query'),
      headers: {...Constants.contentType, 'accessToken': token},
    );
    var videos = (json.decode(response.body)['items'] as List)
        .map((e) => Video.fromMap(e))
        .toList();
    state = [...state, ...videos];
    dev.log('Videos state set as $state');
    ref.read(nextPageTokenProvider.notifier).set(
          json.decode(response.body)['nextPageToken'],
        );
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
