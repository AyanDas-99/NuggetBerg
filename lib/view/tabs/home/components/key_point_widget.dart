import 'package:flutter/material.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';

class KeyPointWidget extends StatelessWidget {
  final Point point;
  const KeyPointWidget({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withAlpha(15),
            Colors.blue.withAlpha(15),
            Colors.green.withAlpha(15),
            Colors.red.withAlpha(15),
            Colors.indigoAccent.withAlpha(15),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(7),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              point.header,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
            ...point.subPoints.map((e) => RichText(
                strutStyle: const StrutStyle(height: 1.5),
                text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${e.title}  ',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: e.text,
                        style: const TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 12),
                      ),
                    ]))),
          ],
        ),
      ),
    );
  }
}
