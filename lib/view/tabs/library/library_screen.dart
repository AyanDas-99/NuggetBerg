import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/library/components/library_full_list.dart';
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
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LibraryFullList(
                        title: liked,
                        videos: user.favourites
                            .map((e) => e['video_id'] as String)
                            .toList(),
                      ),
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(liked),
                  subtitle: Text('${user!.favourites.length} nuggets'),
                  trailing: const Icon(Icons.navigate_next),
                  leading: const Icon(CupertinoIcons.heart_fill),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LibraryFullList(
                          title: bookmarks,
                          videos: user.favourites
                              .map((e) => e['video_id'] as String)
                              .toList() ),
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(bookmarks),
                  subtitle: const Text('6 nuggets'),
                  trailing: const Icon(Icons.navigate_next),
                  leading: const Icon(Icons.bookmark),
                ),
                const SizedBox(height: 20),
                Section(section: history),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
