import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'next_page_token.g.dart';

@riverpod
class NextPageToken extends _$NextPageToken {
  @override
  String? build() {
    return null;
  }

  void update(String? token) {
    state = token;
  }
}