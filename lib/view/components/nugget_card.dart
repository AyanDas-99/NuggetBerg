import 'package:flutter/material.dart';
import 'package:nugget_berg/state/videos/models/video.dart';

class NuggetCard extends StatelessWidget {
  const NuggetCard({super.key, required this.video});
  final Video video;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Material(),
          ));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              video.thumbnail,
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  video.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
