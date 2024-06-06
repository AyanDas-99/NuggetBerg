import 'dart:convert';
import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
part 'videos.g.dart';

@riverpod
class VideoProvider extends _$VideoProvider {
  @override
  List<Video> build() {
    return [];
  }

  Future<List<Video>> updateList() async {
    var response = await http.get(Uri.parse('${Constants.baseUrl}/videos'));
    var videos = (json.decode(response.body)['items'] as List)
        .map((e) => Video.fromMap(e))
        .toList();
    state = videos;
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
