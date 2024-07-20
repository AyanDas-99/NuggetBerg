import 'package:flutter/material.dart';
import 'package:nugget_berg/view/theme/profile.dart';

List<Profile> get allAppProfiles {
  return [
    Profile(
      title: 'flamingo',
      image: 'assets/images/profiles/flamingo.png',
      gradient: const LinearGradient(
        colors: [
          Color(0xfffad0c4),
          Color(0xffffd1ff),
        ],
      ),
    ),
    Profile(
        title: 'bluewhale',
        image: 'assets/images/profiles/whale.png',
        gradient: const LinearGradient(
          colors: [
            Color(0xffbdc2e8),
            Color(0xffe6dee9),
          ],
        )),
    Profile(
        title: 'nighteye',
        image: 'assets/images/profiles/eyes.png',
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF434343),
          ],
        )),
    Profile(
        title: 'mrcool',
        image: 'assets/images/profiles/glasses.png',
        gradient: const LinearGradient(
          colors: [
            Color(0xFF232526),
            Color(0xFF414345),
          ],
        ))
  ];
}

