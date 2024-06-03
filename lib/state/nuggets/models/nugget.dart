import 'dart:convert';
import 'package:nugget_berg/state/nuggets/strings/nugget_fields.dart';

class Nugget {
  final String videoId;
  final List<Point> points;
  const Nugget({
    required this.videoId,
    required this.points,
  });

  factory Nugget.fromMap(Map<String, dynamic> map) {
    final List items = map[NuggetFields.items];
    return Nugget(
      videoId: map[NuggetFields.id] as String,
      points: List<Point>.from(
        (items).map<Point>(
          (x) => Point.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Nugget.fromJson(String source) =>
      Nugget.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Nugget(videoId: $videoId, points: $points)';
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
