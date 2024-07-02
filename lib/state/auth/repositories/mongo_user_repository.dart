import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nugget_berg/state/constants.dart';
import 'package:http/http.dart' as http;
import 'package:nugget_berg/state/auth/models/user.dart' as userModel;
import 'dart:developer' as dev;

class MongoUserRepository {
  Future<userModel.User?> getUser() async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if (token == null) {
        dev.log('Could not get mongo user; token is null');
        return null;
      }
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/user'),
        headers: {...Constants.contentType, 'accessToken': token},
      );
      if (response.statusCode == 200) {
        return userModel.User.fromJson(response.body);
      } else {
        dev.log(response.toString());
        return null;
      }
    } catch (e) {
      dev.log('Error getting user from mongo', error: e);
      return null;
    }
  }

  Future<userModel.User?> setNextPageToken(String? nextPage) async {
    dev.log('Setting nextPageToken');
    if (nextPage == null) {
      print('Next page token empty');
      return null;
    }

    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
       if (token == null) {
        dev.log('Could not set nextPageToken, user IdToken is null');
        return null;
      }
      
      final response = await http.post(
          Uri.parse('${Constants.baseUrl}/user/add-nextpage'),
          headers: {...Constants.contentType, 'accessToken': token},
          body: jsonEncode({"nextPage": nextPage}));
      if (response.statusCode == 200) {
        return userModel.User.fromJson(response.body);
      } else {
        dev.log(response.toString());
        return null;
      }
    } catch (e) {
      dev.log('Error addToFav', error: e);
      return null;
    }
  }

  Future<userModel.User?> addToFavourite(String videoId) async {
    dev.log('Adding to favourite..');
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
       if (token == null) {
        dev.log('Could not add to favourite, user IdToken is null');
        return null;
      }
      final response = await http.post(
          Uri.parse('${Constants.baseUrl}/user/add-to-favourite'),
          headers: {...Constants.contentType, 'accessToken': token},
          body: jsonEncode({"video_id": videoId}));
      if (response.statusCode == 200) {
        return userModel.User.fromJson(response.body);
      } else {
        dev.log(response.toString());
        return null;
      }
    } catch (e) {
      dev.log('Error addToFav', error: e);
      return null;
    }
  }

  Future<userModel.User?> addToViewed(String videoId) async {
    dev.log('Adding to viewed..');
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
       if (token == null) {
        dev.log('Could not add to viewed, user IdToken is null');
        return null;
      }
      final response = await http.post(
          Uri.parse('${Constants.baseUrl}/user/add-to-viewed'),
          headers: {...Constants.contentType, 'accessToken': token},
          body: jsonEncode({"video_id": videoId}));
      if (response.statusCode == 200) {
        return userModel.User.fromJson(response.body);
      } else {
        dev.log(response.toString());
        return null;
      }
    } catch (e) {
      dev.log('Error adding to viewed', error: e);
      return null;
    }
  }
}
