import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/firebase_options.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';
import 'package:nugget_berg/state/auth/providers/is_logged_in.dart';
import 'package:nugget_berg/state/providers/scaffold_messenger_key.dart';
import 'package:nugget_berg/state/providers/startup_initialize.dart';
import 'package:nugget_berg/view/components/startup_loading.dart';
import 'package:nugget_berg/view/onboarding/onboarding_screen.dart';
import 'package:nugget_berg/view/tabs/tab_view_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      scaffoldMessengerKey: ref.watch(scaffoldMessagerKeyProvider),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Raleway',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AppStartupWidget(),
    );
  }
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. eagerly initialize startupInitializeProvider (and all the providers it depends on)
    final appStartupState = ref.watch(startupInitilizeProvider);

    final isLogged = ref.watch(isLoggedInProvider);
    return appStartupState.when(
      // 3. loading state
      loading: () => const StartupLoading(),
      // 4. error state
      error: (e, st) => Scaffold(
        body: Column(
          children: [
            Text(e.toString()),
            TextButton(
              onPressed: () {
                ref.invalidate(startupInitilizeProvider);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      // 6. success - now load the main app
      data: (_) =>
          isLogged ? const TabViewController() : const OnBoardingScreen(),
    );
  }
}
