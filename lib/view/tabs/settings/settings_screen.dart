import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/nuggets/providers/nugget_by_video_id.dart';
import 'package:nugget_berg/state/videos/models/video.dart';
import 'package:nugget_berg/view/all_strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Text('Settings'),
    );
  }
}
