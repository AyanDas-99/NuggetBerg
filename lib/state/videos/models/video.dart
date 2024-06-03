import 'dart:convert';
import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String channelId;
  final String title;
  final String description;
  final String thumbnail;
  final String channelTitle;
  const Video({
    required this.id,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id']['videoId'] as String,
      channelId: map['snippet']['channelId'] as String,
      title: map['snippet']['title'] as String,
      description: map['snippet']['description'] as String,
      thumbnail: map['snippet']['thumbnails']['default']['url'] as String,
      channelTitle: map['snippet']['channelTitle'] as String,
    );
  }

  factory Video.fromJson(String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Video(id: $id, channelId: $channelId, title: $title, description: $description, thumbnail: $thumbnail, channelTitle: $channelTitle)';
  }

  @override
  List<Object?> get props => [id, title, channelTitle, thumbnail];
}
