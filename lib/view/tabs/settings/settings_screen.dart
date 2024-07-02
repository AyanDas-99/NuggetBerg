import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user.dart';
import 'package:nugget_berg/view/all_strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(mongoUserProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          settings,
          style: const TextStyle(fontWeight: FontWeight.w200),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          if(user != null)
          Text(user.email),
          IconButton(onPressed: () {
            ref.read(mongoUserProvider.notifier).getUser();
          }, icon: const Icon(Icons.person)),
        ],
      ),
    );
  }
}
