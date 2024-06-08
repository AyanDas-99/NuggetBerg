import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nugget_berg/state/auth/models/user.dart' as userModel;
import 'package:nugget_berg/state/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
part 'user.g.dart';

@riverpod
class MongoUser extends _$MongoUser {
  @override
  userModel.User? build() {
    getUser();
    return null;
  }

  Future getUser() async {
    try {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    dev.log(token.toString());
    if (token == null) return;
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/user'),
      headers: {...Constants.contentType, 'accessToken': token},
    );
    dev.log(response.body);
    if (response.statusCode == 200) {
      state = userModel.User.fromJson(response.body);
    }
    } catch(e) {
      dev.log('Error getting user from mongo', error: e);
    }
  }

  Future addToFavourite(String videoId) async {
    dev.log('Adding to favourite..');
    try {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    if (token == null) return;
    final response = await http.post(
        Uri.parse('${Constants.baseUrl}/user/add-to-favourite'),
        headers: {...Constants.contentType, 'accessToken': token},
        body: jsonEncode({"video_id": videoId}));
    if (response.statusCode == 200) {
      state = userModel.User.fromJson(response.body);
    }
    } catch(e) {
      dev.log('Error addToFav', error: e);
    }
  }
}
