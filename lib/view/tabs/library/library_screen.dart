import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/library/components/section.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  Future refresh() async {
    await ref.read(mongoUserProvider.notifier).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(mongoUserProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          myLibrary,
          style: const TextStyle(fontWeight: FontWeight.w200),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Section(
                  section: liked,
                  videosIds: user!.favourites
                      .map((e) => e['video_id'] as String)
                      .toList(),
                ),
                const SizedBox(height: 20),
                Section(
                  section: history,
                  videosIds:
                      user.viewed.map((e) => e['video_id'] as String).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
