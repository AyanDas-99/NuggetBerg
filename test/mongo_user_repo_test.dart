import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nugget_berg/state/auth/models/user.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user_repository.dart';
import 'package:nugget_berg/state/auth/repositories/mongo_user_repository.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

class MockMongoUserRepository extends Mock implements MongoUserRepository {
  @override
  Future<User?> getUser() async{
    return User(id: 'id', email: 'email', favourites: [], viewed: [], nextPage: '1');
  }
}

void main() {
  late MockMongoUserRepository mockMongoUserRepository;

  setUp(() {
    mockMongoUserRepository = MockMongoUserRepository();
  });

  ProviderContainer createContainerWithoverrides() {
    return createContainer(overrides: [
      mongoUserRepositoryProvider.overrideWith((ref) {
        return mockMongoUserRepository;
      },)
    ]);
  }

  test('mongoUserRepository sets and returns nextToken', () async {
    when(() => mockMongoUserRepository.setNextPageToken('2'))
        .thenAnswer((_) async {
      return User(id: 'id', email: 'email', favourites: [], viewed: [], nextPage: '2');
    });
    // when(() => mockMongoUserRepository.getUser())
    //     .thenAnswer((_) async {
    //   return User(id: 'id', email: 'email', favourites: [], viewed: [], nextPage: '1');
    // });

    final container = createContainerWithoverrides();

    await container.read(mongoUserProvider.notifier).setNextPageToken('2');

    expect(container.read(mongoUserProvider), User(id: 'id', email: 'email', favourites: [], viewed: [], nextPage: '2'));
    
  });
}
