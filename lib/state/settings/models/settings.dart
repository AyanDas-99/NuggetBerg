// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:nugget_berg/state/settings/models/constants.dart';

class Settings extends Equatable {
  final String userId;
  final bool? storeHistory;
  final bool? showHistory;
  final bool? showLiked;

  const Settings(
      {required this.userId,
      this.storeHistory,
      this.showHistory,
      this.showLiked});

  @override
  List<Object?> get props => [userId, storeHistory, showHistory, showLiked];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SettingsFieldNames.userId: userId,
      SettingsFieldNames.storeHistory: storeHistory,
      SettingsFieldNames.showHistory: showHistory,
      SettingsFieldNames.showLiked: showLiked,
    };
  }

  static Settings initial() => const Settings(
      userId: '', storeHistory: true, showHistory: true, showLiked: true);

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      userId: map[SettingsFieldNames.userId] as String,
      storeHistory: map[SettingsFieldNames.storeHistory] != null
          ? map[SettingsFieldNames.storeHistory] as bool
          : null,
      showHistory: map[SettingsFieldNames.showHistory] != null
          ? map[SettingsFieldNames.showHistory] as bool
          : null,
      showLiked: map[SettingsFieldNames.showLiked] != null
          ? map[SettingsFieldNames.showLiked] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return toJson();
  }

  Settings copyWith({
    String? userId,
    bool? storeHistory,
    bool? showHistory,
    bool? showLiked,
  }) {
    return Settings(
      userId: userId ?? this.userId,
      storeHistory: storeHistory ?? this.storeHistory,
      showHistory: showHistory ?? this.showHistory,
      showLiked: showLiked ?? this.showLiked,
    );
  }
}
