import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/theme/app_gradient.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradients = ref.watch(allAppGradientsProvider);
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
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        children: [
          ...gradients.map(
            (e) => InkWell(
              onTap: () {
                ref.read(appGradientProvider.notifier).change(e);
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: e,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                ref.read(authRepositoryNotifierProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
