import 'package:nugget_berg/state/auth/providers/mongo_user.dart';
import 'package:nugget_berg/state/settings/providers/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nugget_berg/state/settings/models/settings.dart' as model;
import 'dart:developer' as dev;
part 'settings.g.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  model.Settings? build() {
    return null;
  }

  Future<void> getSettings() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    var settings = await settingsRepo.getSettings();
    final user = ref.read(mongoUserProvider);
    if (settings == null) {
      if (user == null) {
        dev.log('Cannot get / set settings; user is null');
        return;
      }
      updateSettings(
        model.Settings(
          showHistory: true,
          showLiked: true,
          storeHistory: true,
          userId: ref.read(mongoUserProvider)!.id,
        ),
      );
    } else {
      state = settings;
    }
  }

  Future<void> updateSettings(model.Settings settings) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final newSettings = await settingsRepo.updateSettings(settings);
    if (newSettings != null) {
      state = newSettings;
    }
  }
}
