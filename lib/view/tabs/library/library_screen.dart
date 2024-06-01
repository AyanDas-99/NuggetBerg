import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/library/components/library_full_list.dart';
import 'package:nugget_berg/view/tabs/library/components/section.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LibraryFullList(title: liked),
                  ));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(liked),
                subtitle: const Text('12 nuggets'),
                trailing: const Icon(Icons.navigate_next),
                leading: const Icon(CupertinoIcons.heart_fill),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LibraryFullList(title: bookmarks),
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
    );
  }
}
