import 'package:nugget_berg/state/auth/repositories/auth_repository.dart';
import 'package:nugget_berg/state/auth/models/auth_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_logged_in.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  return ref.watch(authRepositoryNotifierProvider).authResult ==
      AuthResult.success;
}
