import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nugget_berg/view/tabs/home/components/key_point_widget.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOU4ZwXLhqyebgok9yT4o0-vskE_hwEvZDtA&usqp=CAU',
              width: double.infinity,
              height: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'How to get rich in your 20s',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KeyPointWidget(text: 'Get better at talking to people.'),
              KeyPointWidget(text: 'Work hard to get your goals'),
              KeyPointWidget(text: 'Do what makes you happy'),
              KeyPointWidget(text: 'Face your fears from now on out.'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.heart),
                // color: Colors.red,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(CupertinoIcons.bookmark_fill),
                onPressed: () {},
              ),
            ],
          ),
          Spacer(),
          Center(
            child: Transform.rotate(
                angle: math.pi / 2,
                child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.blueGrey.shade100,
                    direction: ShimmerDirection.btt,
                    child: Icon(CupertinoIcons.chevron_left_2))),
          )
        ],
      ),
    );
  }
}
