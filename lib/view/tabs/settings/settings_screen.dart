import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/providers/mongo_user.dart';
import 'package:nugget_berg/state/auth/repositories/auth_repository.dart';
import 'package:nugget_berg/state/settings/providers/settings.dart';
import 'package:nugget_berg/view/all_strings.dart' as strings;
import 'package:nugget_berg/state/settings/models/settings.dart' as model;
import 'package:nugget_berg/view/tabs/settings/components/loader.dart';
import 'package:nugget_berg/view/tabs/settings/components/logout_dialog.dart';
import 'package:nugget_berg/view/tabs/settings/components/profile_bottom_sheet.dart';
import 'package:nugget_berg/view/theme/constants/profiles.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
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

  openProfileBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ProfileBottomSheet(),
    );
  }

  logout(BuildContext context) async {
    bool? logout = await showDialog(
      context: context,
      builder: (context) => logoutDialog(context),
    );

    if (logout == true) {
      ref.read(authRepositoryNotifierProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final profile = settings?.profile ?? allAppProfiles.first;
    final authLoading = ref.watch(
        authRepositoryNotifierProvider.select((state) => state.isLoading));
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black26,
                  )),
              Expanded(flex: 5, child: Container()),
            ],
          ),
          RefreshIndicator(
            onRefresh: () async {
              await ref.read(mongoUserProvider.notifier).getUser();
              await ref.read(settingsProvider.notifier).getSettings();
              return;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            strings.settings,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Loader(loading: isLoading),
                                      // Profile
                                      ListTile(
                                        onTap: () => openProfileBottomSheet(),
                                        leading: CircleAvatar(
                                          child: Image.asset(
                                            profile.image,
                                            height: 30,
                                          ),
                                        ),
                                        title: Text(strings.profile),
                                        trailing: const CircleAvatar(
                                            child: Icon(Icons.navigate_next)),
                                      ),
                                      const Divider(thickness: 0.5),
                                      ListTile(
                                        title: Text(strings.storeHistory),
                                        trailing: Switch(
                                          trackOutlineColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.transparent),
                                          value: settings?.storeHistory ?? true,
                                          onChanged: (bool value) => update(
                                            settings!
                                                .copyWith(storeHistory: value),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(strings.showHistory),
                                        trailing: Switch(
                                          trackOutlineColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.transparent),
                                          value: settings?.showHistory ?? true,
                                          onChanged: (bool value) => update(
                                            settings!
                                                .copyWith(showHistory: value),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(strings.showLiked),
                                        trailing: Switch(
                                          trackOutlineColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.transparent),
                                          value: settings?.showLiked ?? true,
                                          onChanged: (bool value) => update(
                                            settings!
                                                .copyWith(showLiked: value),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Log out
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    onTap: () => logout(context),
                                    title: Text(
                                      strings.logout,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    trailing: const Icon(
                                      Icons.logout_sharp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Loading for auth
          if (authLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
