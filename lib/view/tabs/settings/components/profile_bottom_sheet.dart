import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/settings/providers/settings.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/settings/components/loader.dart';
import 'package:nugget_berg/view/theme/constants/profiles.dart';
import 'package:nugget_berg/state/settings/models/settings.dart' as model;

class ProfileBottomSheet extends ConsumerStatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  ConsumerState<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends ConsumerState<ProfileBottomSheet> {
  bool isLoading = false;

  update(model.Settings settings) async {
    setState(() {
      isLoading = true;
    });
    await ref.read(settingsProvider.notifier).updateSettings(settings);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final currentProfile = settings?.profile ?? allAppProfiles.first;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Loader(loading: isLoading),
          Text(
            changeProfile,
            style: const TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                allAppProfiles.length,
                (index) {
                  final profile = allAppProfiles[index];
                  bool selected = profile == currentProfile;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            update(
                                settings!.copyWith(profile: profile.title));
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
        ],
      ),
    );
  }
}
