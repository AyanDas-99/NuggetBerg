import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'next_page_token.g.dart';

@Riverpod(keepAlive: true)
class NextPageToken extends _$NextPageToken {
  @override
  String build() {
    return '';
  }

  set(String token) => state = token;
}
