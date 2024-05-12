import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nugget_berg/state/auth/models/auth_result.dart';
import 'package:nugget_berg/state/auth/models/auth_state.dart';
import 'package:nugget_berg/state/providers/scaffold_messenger.dart';
import 'dart:developer' as developer;

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepositoryNotifier extends _$AuthRepositoryNotifier {
  @override
  AuthState build() {
    if (_fAUth.currentUser != null && _fAUth.currentUser?.phoneNumber != null) {
      return AuthState(
          authResult: AuthResult.success,
          isLoading: false,
          userId: _fAUth.currentUser?.uid);
    }
    return const AuthState.unknown();
  }

  final FirebaseAuth _fAUth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // final userStorage = UserStorageRepository();
  Future googleLogin() async {
    state = state.copyWithIsLoading(true);
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _fAUth.signInWithCredential(credential);
      // final stored = await userStorage.storeUserToDb(_fAUth.currentUser!);
      state = AuthState(
          authResult: AuthResult.success,
          isLoading: false,
          userId: _fAUth.currentUser?.uid);
    } catch (e) {
      developer.log("Google login error", error: e);
    }
    state = state.copyWithIsLoading(false);
  }

  Future createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _fAUth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fAUth.currentUser?.sendEmailVerification();
      developer.log("Email verification sent");
      // show scaffold messenger

      ref.read(scaffoldMessengerProvider).showSnackBar(
          SnackBar(content: Text('Verfication email sent to $email')));
      //
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWithIsLoading(true);
      Timer.periodic(const Duration(seconds: 15), (timer) async {
        _fAUth.currentUser?.reload();
        if (_fAUth.currentUser?.emailVerified == true) {
          timer.cancel();

          // final stored = await userStorage.storeUserToDb(_fAUth.currentUser!);
          state = AuthState(
              authResult: AuthResult.success,
              isLoading: false,
              userId: _fAUth.currentUser?.uid);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        developer.log('The password provided is too weak.');
        ref.read(scaffoldMessengerProvider).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        developer.log('The account already exists for that email.');
        ref.read(scaffoldMessengerProvider).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      } else {
        developer.log(e.toString());
        ref
            .read(scaffoldMessengerProvider)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }

  Future emailLogin({required String email, required String password}) async {
    // state = true;
    state = state.copyWithIsLoading(true);
    try {
      await _fAUth.signInWithEmailAndPassword(email: email, password: password);
      state = AuthState(
          authResult: AuthResult.success,
          isLoading: false,
          userId: _fAUth.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      ref
          .read(scaffoldMessengerProvider)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
    // state = false;
    state = state.copyWithIsLoading(false);
  }

  Future<void> signOut() async {
    state = state.copyWithIsLoading(true);
    try {
      _fAUth.signOut();
      _googleSignIn.signOut();
      state = const AuthState.unknown();
    } catch (e) {
      developer.log("Sign out error", error: e);
    }
    state = state.copyWithIsLoading(false);
  }
}
