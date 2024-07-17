import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class VideoRepository {
  Future<VideosAndNextPageToken> getVideos(
      {required String accessToken, String? nextPageToken}) async {
    final query = (nextPageToken != null) ? '?nextPage=$nextPageToken' : '';
    var response = await http.get(
      Uri.parse('${Constants.baseUrl}/videos$query'),
      headers: {...Constants.contentType, 'accessToken': accessToken},
    );
    final videos = (json.decode(response.body)['items'] as List)
        .map((e) => Video.fromMap(e))
        .toList();

    final token = json.decode(response.body)['nextPageToken'] as String;

    return VideosAndNextPageToken(videos: videos, nextPageToken: token);
  }

  Future<Video?> getVideoById(
      {required String id, required String accessToken}) async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.baseUrl}/video-by-id?id=$id'),
          headers: {...Constants.contentType, 'accessToken': accessToken});
      final video =
          Video.fromMap((json.decode(response.body)['items'] as List).first);
      return video;
    } catch (e) {
      dev.log('Error getting video by id', error: e);
      return null;
    }
  }

  Future<Nugget?> getNuggetFromVideo({required Video video}) async {
    var response = await http
        .get(Uri.parse('${Constants.baseUrl}/summary/db?videoId=${video.id}'));
    if (response.statusCode != 200) return null;
    return Nugget.fromJson(response.body, video);
  }
}

class VideosAndNextPageToken extends Equatable {
  final List<Video> videos;
  final String nextPageToken;

  const VideosAndNextPageToken(
      {required this.videos, required this.nextPageToken});

  @override
  List<Object?> get props => [videos, nextPageToken];
}
