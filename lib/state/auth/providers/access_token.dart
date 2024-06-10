import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'access_token.g.dart';

@riverpod
Future<String?> accessToken(AccessTokenRef ref) async{
  final token =await FirebaseAuth.instance.currentUser!.getIdToken();
  return token;
}