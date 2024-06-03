import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainContentLoading extends StatelessWidget {
  const MainContentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black.withAlpha(10),
      highlightColor: Colors.grey.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.black,
                width: double.infinity,
                height: 160,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 200,
                height: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.43,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                  icon: Icon(CupertinoIcons.heart),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(CupertinoIcons.bookmark_fill),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
