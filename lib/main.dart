import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/firebase_options.dart';
import 'package:nugget_berg/state/providers/scaffold_messenger_key.dart';
import 'package:nugget_berg/view/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLogged = ref.watch(isLoggedInProvider);
    // final authLoading = ref.watch(
    //     authRepositoryNotifierProvider.select((value) => value.isLoading));
    return MaterialApp(
      scaffoldMessengerKey: ref.watch(scaffoldMessagerKeyProvider),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Raleway',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
    );
  }
}
