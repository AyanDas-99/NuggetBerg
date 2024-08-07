// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:nugget_berg/state/auth/models/user_field_names.dart';

class User extends Equatable{
  final String id;
  final String email;
  final List<Map<String, dynamic>> favourites;
  final List<Map<String, dynamic>> viewed;
  final String? nextPage;
  const User({
    required this.id,
    required this.email,
    required this.favourites,
    required this.viewed,
    this.nextPage,
  });

  User copyWith({
    String? id,
    String? email,
    List<Map<String, dynamic>>? favourites,
    List<Map<String, dynamic>>? viewed,
    String? nextPage,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      favourites: favourites ?? this.favourites,
      viewed: viewed ?? this.viewed,
      nextPage: nextPage,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map[UserFieldNames.id] as String,
      email: map[UserFieldNames.email] as String,
      favourites:
          List<Map<String, dynamic>>.from((map[UserFieldNames.favourites])),
      viewed: List<Map<String, dynamic>>.from((map[UserFieldNames.viewed])),
      nextPage: map[UserFieldNames.nextPage],
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, email: $email, favourites: $favourites, viewed: $viewed)';
  }

  @override
  List<Object?> get props => [id, email, favourites, viewed, nextPage];
}
