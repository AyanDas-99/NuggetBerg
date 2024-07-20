import 'package:firebase_auth/firebase_auth.dart';
import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/settings/models/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class SettingsRepository {
  ///updates the setting
  ///
  ///sends the `settings.toJson()` value to server
  Future<Settings?> updateSettings(Settings settings) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if (token == null) {
        dev.log('Could not update settings, user IdToken is null');
        return null;
      }

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/user/update-settings'),
        headers: {...Constants.contentType, 'accessToken': token},
        body: settings.toJson(),
      );

      final updatedSetting = Settings.fromJson(response.body);
      return updatedSetting;
    } catch (e) {
      dev.log('Error updating user settings', error: e);
      return null;
    }
  }

  Future<Settings?> getSettings() async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if (token == null) {
        dev.log('Could not get settings, user IdToken is null');
        return null;
      }

      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/user/settings'),
        headers: {...Constants.contentType, 'accessToken': token},
      );
      if (response.statusCode == 200) {
        final updatedSetting = Settings.fromJson(response.body);
        return updatedSetting;
      } else {
        dev.log(response.body);
        return null;
      }
    } catch (e) {
      dev.log('Error fetching user settings', error: e);
      return null;
    }
  }
}
