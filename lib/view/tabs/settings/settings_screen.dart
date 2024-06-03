import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/nuggets/providers/nugget_by_video_id.dart';
import 'package:nugget_berg/view/all_strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nugget = ref.watch(nuggetByVideoIdProvider('Oar9pkc7BSc'));
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
      body: Center(
        child: nugget.when(
            data: (nugget) => Text(nugget.toString()),
            error: (e, st) => Text(e.toString()),
            loading: () => CircularProgressIndicator()),
      ),
    );
  }
}
