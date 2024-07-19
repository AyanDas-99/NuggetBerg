import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/view/theme/app_profile.dart';

class ProfileBottomSheet extends ConsumerWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(appProfileProvider.notifier).allAppProfiles;
    final currentProfile = ref.watch(appProfileProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Change profile",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 200,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  profiles.length,
                  (index) {
                    final profile = profiles[index];
                    bool selected = profile == currentProfile;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ref.read(appProfileProvider.notifier).change(profile);
                            },
                            child: CircleAvatar(
                              backgroundColor: profile.gradient.colors.last,
                              radius: 50,
                              child: Image.asset(
                                profile.image,
                                height: 50,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 5,
                            color: selected ? Colors.red.shade200 : null,
                            width: 50,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
