import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';
import 'package:nugget_berg/state/constants.dart';

class UserStorageRepository {
  Future<bool> storeUserToDb(Ref ref) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      print(token);
      final response = await http.post(
          Uri.parse('${Constants.baseUrl}/user/create'),
          headers: {...Constants.contentType, 'accessToken': token!});

      developer.log(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      developer.log("User storage to mongo error", error: e);
      ref.read(authRepositoryNotifierProvider.notifier).signOut();
    }
    return false;
  }
}
