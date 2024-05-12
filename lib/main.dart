import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/firebase_options.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';
import 'package:nugget_berg/state/auth/providers/is_logged_in.dart';
import 'package:nugget_berg/state/providers/scaffold_messenger_key.dart';
import 'package:nugget_berg/view/auth/screens/auth_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogged = ref.watch(isLoggedInProvider);
    final authLoading = ref.watch(
        authRepositoryNotifierProvider.select((value) => value.isLoading));
    return MaterialApp(
      scaffoldMessengerKey: ref.watch(scaffoldMessagerKeyProvider),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          isLogged ? const HomePage() : const AuthScreenController(),
          if (authLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          return TextButton(
              onPressed: () {
                ref.read(authRepositoryNotifierProvider.notifier).signOut();
              },
              child: Text('Log out'));
        }),
      ),
    );
  }
}
