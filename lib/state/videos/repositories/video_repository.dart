import 'dart:convert';

import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:http/http.dart' as http;

class VideoRepository {
  Future<List<Video>> getVideos(
      {required String accessToken, String? nextPageToken}) async {
    final query = (nextPageToken != null) ? '?nextPage=$nextPageToken' : '';
    var response = await http.get(
      Uri.parse('${Constants.baseUrl}/videos$query'),
      headers: {...Constants.contentType, 'accessToken': accessToken},
    );
    return (json.decode(response.body)['items'] as List)
        .map((e) => Video.fromMap(e))
        .toList();
  }
}
