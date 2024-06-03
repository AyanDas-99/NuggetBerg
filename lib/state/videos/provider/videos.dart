import 'dart:convert';

import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'videos.g.dart';

@riverpod
class video extends _$video {
  @override
  List<Video> build() {
    return [];
  }

  updateList() async {
    var videos = await http.get(Uri.parse('${Constants.baseUrl}/videos'));
    state = (json.decode(videos.body)['items'] as List)
        .map((e) => Video.fromMap(e))
        .toList();
  }
}
