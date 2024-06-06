import 'dart:convert';
import 'package:nugget_berg/state/nuggets/strings/nugget_fields.dart';
import 'package:nugget_berg/state/videos/models/video.dart';

class Nugget {
  final Video video;
  final List<Point> points;
  const Nugget({
    required this.video,
    required this.points,
  });

  factory Nugget.fromMap(Map<String, dynamic> map, Video video) {
    final List items = map[NuggetFields.items];
    return Nugget(
      video: video,
      points: List<Point>.from(
        (items).map<Point>(
          (x) => Point.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Nugget.fromJson(String source, Video video) =>
      Nugget.fromMap(json.decode(source) as Map<String, dynamic>, video);

  // @override
  // String toString() => 'Nugget(videoId: $videoId, points: $points)';
  @override
  String toString() => 'Nugget(videoId: ${video.id})';
}

class Point {
  final String header;
  final List<SubPoint> subPoints;
  const Point({
    required this.header,
    required this.subPoints,
  });

  factory Point.fromMap(Map<String, dynamic> map) {
    final List points = map[NuggetFields.points];
    return Point(
      header: map[NuggetFields.header] as String,
      subPoints: List<SubPoint>.from(
        (points).map<SubPoint>(
          (x) => SubPoint.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Point.fromJson(String source) =>
      Point.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Point(header: $header, subPoints: $subPoints)';
}

class SubPoint {
  final String title;
  final String text;

  const SubPoint({
    required this.title,
    required this.text,
  });

  factory SubPoint.fromMap(Map<String, dynamic> map) {
    return SubPoint(
      title: map[NuggetFields.title] as String,
      text: map[NuggetFields.text] as String,
    );
  }

  factory SubPoint.fromJson(String source) =>
      SubPoint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Point(title: $title, text: $text)';
}
