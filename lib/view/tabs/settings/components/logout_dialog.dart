import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/components/main_button.dart';

Widget logoutDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.white.withOpacity(0.9),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(logout),
        IconButton(
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pop(false);
            }
          },
        ),
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(doYouWantToLogOut),
        const SizedBox(height: 30),
        MainButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            },
            backgroundColor: Colors.red.shade400,
            padding: const EdgeInsets.all(10),
            child: Text(
              logout,
              style: const TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
}
