import 'package:nugget_berg/state/auth/repositories/mongo_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mongo_user_repository.g.dart';

@riverpod
MongoUserRepository mongoUserRepository(MongoUserRepositoryRef ref) {
  return MongoUserRepository();
}