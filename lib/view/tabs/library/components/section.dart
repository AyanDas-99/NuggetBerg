import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/components/nugget_card.dart';
import 'package:nugget_berg/view/tabs/library/components/library_full_list.dart';

class Section extends StatelessWidget {
  final String section;
  const Section({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        ...List.generate(
          4,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: NuggetCard(),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LibraryFullList(title: bookmarks),
            ));
          },
          child: Text(
            showMore,
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
